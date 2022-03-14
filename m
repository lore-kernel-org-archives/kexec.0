From: Philipp Rudo <prudo@redhat.com>
Date: Mon, 14 Mar 2022 17:04:28 +0100
Subject: [PATCH v2 0/4] makedumpfile: harden parsing of old prink buffer
Message-ID: <20220314160432.9414-1-prudo@redhat.com>
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

v2:
	* Rename 'idx' to 'ptr'
	* Also print the non-loop part when a cycle was detected. Such a
	  situation can happen when log_buf wrapped around in the kernel
	  (log_first_idx != 0) and the corruption occurred on an
	  idx < log_first_idx.
	* Add patch 4 fixing a bug independent from the memory corruption but
	  found while investigating it.

Philipp Rudo (4):
  makedumpfile: add generic cycle detection
  makedumpfile: use pointer arithmetics for dump_dmesg
  makedumpfile: use cycle detection when parsing the prink log_buf
  makedumpfile: print error when reading with unsupported compression

 Makefile       |   2 +-
 detect_cycle.c |  99 +++++++++++++++++++++++++++++++++++++
 detect_cycle.h |  40 +++++++++++++++
 makedumpfile.c | 131 ++++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 247 insertions(+), 25 deletions(-)
 create mode 100644 detect_cycle.c
 create mode 100644 detect_cycle.h

-- 
2.35.1


