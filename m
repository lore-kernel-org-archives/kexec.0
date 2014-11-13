Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <cover.1415837218.git.geoff@infradead.org>
In-Reply-To: <cover.1408731991.git.geoff@infradead.org>
References: <cover.1408731991.git.geoff@infradead.org
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V3 0/4] kexec: minor fixups and enhancements
Date: Thu, 13 Nov 2014 00:19:32 +0000
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

Hi Andrew,

This is essentially a resend of my patch set from October with the exception
of folding the last two patches of that series into the final patch here.

The patches here have been in review since first posted in August, and have
been acked by one or two kexec developers.  Could you merge them through your
mm tree?  Thanks.

-Geoff


The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.linaro.org/people/geoff.levand/linux-kexec.git for-kexec

for you to fetch changes up to 916ef4b8abaa4202ea43731b9cd3f8e0ea95f05b:

  kexec: Add IND_FLAGS macro (2014-11-12 15:27:54 -0800)

----------------------------------------------------------------
Geoff Levand (4):
      kexec: Fix make headers_check
      kexec: Simplify conditional
      kexec: Add bit definitions for kimage entry flags
      kexec: Add IND_FLAGS macro

 arch/powerpc/kernel/machine_kexec_64.c |  2 --
 include/linux/kexec.h                  | 20 ++++++++++++++++----
 include/uapi/linux/kexec.h             |  6 ------
 kernel/kexec.c                         | 17 ++++++++++-------
 4 files changed, 26 insertions(+), 19 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
