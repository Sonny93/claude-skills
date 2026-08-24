# claude-skills

Skills persos pour [Claude Code](https://claude.com/claude-code). Synchronise ces skills entre plusieurs machines via ce repo.

## Contenu

- `adonis-conventions` — conventions stack AdonisJS
- `plan-phase` — exécute la prochaine phase d'un plan multi-phases local
- `react-conventions` — conventions et archi React

Chaque skill vit dans `~/.claude/skills/<nom>/SKILL.md`. Claude Code les charge automatiquement au démarrage depuis ce dossier.

Ce repo ne contient QUE ces 3 skills (voir `.gitignore`). Les autres skills présents dans `~/.claude/skills` sur la machine d'origine (persos/privés) ne sont pas versionnés ici.

## Installer sur une nouvelle machine

```bash
mkdir -p ~/.claude
git clone https://github.com/Sonny93/claude-skills.git ~/.claude/skills-repo

mkdir -p ~/.claude/skills
for skill in adonis-conventions plan-phase react-conventions; do
  ln -s ~/.claude/skills-repo/$skill ~/.claude/skills/$skill
done
```

Symlink plutôt que copie: un `git pull` dans `~/.claude/skills-repo` met à jour direct le skill utilisé par Claude Code, sans manip supplémentaire.

Si `~/.claude/skills` a déjà des skills persos dessus (dossiers normaux, pas de conflit de nom), les symlinks cohabitent sans souci à côté.

## Mettre à jour un skill

Sur la machine où t'as fait le changement:

```bash
cd ~/.claude/skills   # ou ~/.claude/skills-repo si t'es en symlink
git add -A
git commit -m "update: <skill> - <quoi>"
git push
```

Sur les autres machines:

```bash
cd ~/.claude/skills-repo
git pull
```

(Rien à refaire côté `~/.claude/skills`, les symlinks pointent déjà dessus.)

## Ajouter un nouveau skill au repo plus tard

1. Créer le skill normalement dans `~/.claude/skills/<nom>/SKILL.md`
2. Ajouter les lignes suivantes dans `.gitignore`:
   ```
   !<nom>/
   !<nom>/**
   ```
3. `git add .gitignore <nom>/ && git commit -m "add: <nom> skill" && git push`

## Sécurité

Repo **public** — avant chaque commit, vérifier qu'aucun SKILL.md ne contient de secret, clé API, chemin perso sensible ou donnée client. `git diff --staged` avant de commit.
