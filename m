Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNKiX-00836P-8R
 for kexec@lists.infradead.org; Fri, 19 Mar 2021 19:23:31 +0000
Received: by mail-qk1-x72c.google.com with SMTP id i9so4107189qka.2
 for <kexec@lists.infradead.org>; Fri, 19 Mar 2021 12:23:28 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3 0/1] dump kmessage before machine_kexec
Date: Fri, 19 Mar 2021 15:23:25 -0400
Message-Id: <20210319192326.146000-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, tyhicks@linux.microsoft.com, pmladek@suse.com, ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Changelog
v3
	- Re-sending because it still has not landed in mainline.
	- Sync with mainline
	- Added Acked-by: Baoquan He
v2
	- Added review-by's
	- Sync with mainline

Allow to study performance shutdown via kexec reboot calls by having kmsg
log saved via pstore.

Previous submissions
v1 https://lore.kernel.org/lkml/20200605194642.62278-1-pasha.tatashin@soleen.com
v2 https://lore.kernel.org/lkml/20210126204125.313820-1-pasha.tatashin@soleen.com

Pavel Tatashin (1):
  kexec: dump kmessage before machine_kexec

 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
