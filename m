Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fldsmtpe04.verizon.com ([140.108.26.143])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VzWdY-0004gs-Bz
 for kexec@lists.infradead.org; Sat, 04 Jan 2014 19:11:57 +0000
From: Don Slutz <dslutz@verizon.com>
Subject: [PATCH 0/4] Enable use of crash on xen 4.4.0 vmcore
Date: Sat,  4 Jan 2014 14:11:22 -0500
Message-Id: <1388862686-1832-1-git-send-email-dslutz@verizon.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: crash-utility@redhat.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, Don Slutz <dslutz@verizon.com>, xen-devel@lists.xen.org

With the addition on PVH code to xen 4.4, domain.is_hvm no longer
exists.  This prevents crash from using a xen 4.4.0 vmcore.

Patch 1 "fixes" this.

Patch 2 is a minor fix in that outputing the offset in hex for
domain_domain_flags is different.

Patch 3 is a bug fix to get all "domain_flags" set, not just the 1st
one found.

Patch 4 is a quick way to add domain.guest_type support.

Don Slutz (4):
  Make domian.is_hvm optional
  xen: Fix offset output to be decimal.
  xen: set all domain_flags, not just the 1st.
  Add basic domain.guest_type support.

 xen_hyper.c             | 32 ++++++++++++++++++++++++--------
 xen_hyper_defs.h        |  1 +
 xen_hyper_dump_tables.c |  4 +++-
 3 files changed, 28 insertions(+), 9 deletions(-)

-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
