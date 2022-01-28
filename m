From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Fri, 28 Jan 2022 19:42:20 +0800
Subject: [PATCH 0/5] Update doc and fix some issues about kdump
Message-ID: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Tiezhu Yang (5):
  docs: kdump: update description about sysfs file system support
  docs: kdump: add scp sample to write out the dump file
  kcsan: unset panic_on_warn before calling panic()
  sched: unset panic_on_warn before calling panic()
  kfence: unset panic_on_warn before calling panic()

 Documentation/admin-guide/kdump/kdump.rst | 10 +++++++---
 kernel/kcsan/report.c                     | 10 +++++++++-
 kernel/sched/core.c                       | 11 ++++++++++-
 mm/kfence/report.c                        | 10 +++++++++-
 4 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.1.0


