From: Philipp Rudo <prudo@redhat.com>
Date: Mon,  7 Mar 2022 18:23:19 +0100
Subject: [PATCH 0/3] makedumpfile: harden parsing of old prink buffer
Message-ID: <20220307172322.7909-1-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

dumping the dmesg can cause an endless loop for the old prink mechanism (>
v3.5.0 and < v5.10.0) when the log_buf got corrupted. This series fixes those
cases by adding a cycle detection. The cycle detection is implemented in a
generic way so that it can be reused in other parts of makedumpfile.

Thanks
Philipp

Philipp Rudo (3):
  makedumpfile: add generic cycle detection
  makedumpfile: use pointer arithmetics for dump_dmesg
  makedumpfile: use cycle detection when parsing the prink log_buf

 Makefile       |  2 +-
 detect_cycle.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 detect_cycle.h | 40 ++++++++++++++++++++
 makedumpfile.c | 65 +++++++++++++++++++++++++--------
 4 files changed, 190 insertions(+), 16 deletions(-)
 create mode 100644 detect_cycle.c
 create mode 100644 detect_cycle.h

-- 
2.35.1


