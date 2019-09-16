Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lIR-0002q3-Jy
 for kexec@lists.infradead.org; Mon, 16 Sep 2019 07:19:41 +0000
Date: Mon, 16 Sep 2019 09:19:36 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/arm: undefine __NR_kexec_file_load for arm
Message-ID: <20190916071936.q735mn7fo5sctkix@verge.net.au>
References: <20190916024905.3100-1-quanyang.w@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190916024905.3100-1-quanyang.w@gmail.com>
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
To: quanyang.w@gmail.com
Cc: kexec@lists.infradead.org

On Mon, Sep 16, 2019 at 10:49:05AM +0800, quanyang.w@gmail.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> In the kernel upstream commit 4ab65ba7a5cb
> ("ARM: add kexec_file_load system call number"),
> __NR_kexec_file_load for arm has been defined to be 401.
> This results that even if kexec_file_load isn't implemented
> for arm but the function is_kexec_file_load_implemented()
> will still return true. So undef __NR_kexec_file_load for
> arm architecture.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
