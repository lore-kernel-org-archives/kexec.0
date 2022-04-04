From: Philipp Rudo <prudo@redhat.com>
Date: Mon,  4 Apr 2022 17:50:48 +0200
Subject: [PATCH 0/2] makedumpfile: improve write_kdump_pages_cyclic
Message-ID: <20220404155050.6898-1-prudo@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

I noticed that on s390 makedumpfile sometimes floods the console with

Copying data       : [100.0 %] -           eta: 0s

causing the dump process to slow down dramatically. The patches attached are
two somewhat separate approaches to fix this issue. In my opinion both patches
make sense to be included even when one of them would be enough to fix the
problem described above.

Thanks
Philipp

Philipp Rudo (2):
  makedumpfile: omit unnecessary calls to print_progress
  makedumpfile: break loop after last dumpable page

 makedumpfile.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.35.1


