Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V9Z-0004XN-Rl
 for kexec@lists.infradead.org; Tue, 26 Jan 2021 20:41:41 +0000
Received: by mail-qk1-x729.google.com with SMTP id t63so4714638qkc.1
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2021 12:41:29 -0800 (PST)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v2 0/1] dump kmessage before machine_kexec
Date: Tue, 26 Jan 2021 15:41:24 -0500
Message-Id: <20210126204125.313820-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, tyhicks@linux.microsoft.com, pmladek@suse.com, ebiederm@xmission.com, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Changelog
v2
	- Added review-by's
	- Sync with mainline

Allow to study performance shutdown via kexec reboot calls by having kmsg
log saved via pstore.

Previous submissions
v1 https://lore.kernel.org/lkml/20200605194642.62278-1-pasha.tatashin@soleen.com

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
