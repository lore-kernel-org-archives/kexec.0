Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aagzp-0006DC-PY
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 09:53:38 +0000
Subject: Re: [PATCH V2 0/2] kexec: Make a pair of map/unmap reserved pages in
 error path
References: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <56D56684.9000908@redhat.com>
Date: Tue, 1 Mar 2016 17:53:08 +0800
MIME-Version: 1.0
In-Reply-To: <1456819349-8650-1-git-send-email-mnfhuang@gmail.com>
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
To: Minfei Huang <mnfhuang@gmail.com>, ebiederm@xmission.com, akpm@linux-foundation.org
Cc: mhuang@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

This is a bug fix.

After this, I will try to do a cleanup for crash_unmap/map_reserved_pages()
(only used by S390) to consolidate it with arch_kexec_unprotect/protect_crashkres().

Regards,
Xunlei

On 03/01/2016 at 04:02 PM, Minfei Huang wrote:
> v1:
> - Bisect the patch according to Andrew Morton's suggestion
>
> Minfei Huang (2):
>   kexec: Make a pair of map/unmap reserved pages in error path
>   kexec: Do a cleanup for function kexec_load
>
>  kernel/kexec.c | 112 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 63 insertions(+), 49 deletions(-)
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
