Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x241.google.com ([2607:f8b0:400e:c03::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aafGh-00075E-8j
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 08:02:55 +0000
Received: by mail-pa0-x241.google.com with SMTP id a7so8676882pax.3
 for <kexec@lists.infradead.org>; Tue, 01 Mar 2016 00:02:32 -0800 (PST)
From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH V2 0/2] kexec: Make a pair of map/unmap reserved pages in
 error path
Date: Tue,  1 Mar 2016 16:02:27 +0800
Message-Id: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
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
To: ebiederm@xmission.com, akpm@linux-foundation.org
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Minfei Huang <mnfhuang@gmail.com>

v1:
- Bisect the patch according to Andrew Morton's suggestion

Minfei Huang (2):
  kexec: Make a pair of map/unmap reserved pages in error path
  kexec: Do a cleanup for function kexec_load

 kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
