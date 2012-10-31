Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TTUAf-0003te-8Q
 for kexec@lists.infradead.org; Wed, 31 Oct 2012 09:01:11 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C2BAD3EE0BC
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:01:03 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A6FC345DE59
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:01:03 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9109445DE58
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:01:03 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 83A1E1DB8050
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:01:03 +0900 (JST)
Received: from g01jpexchyt11.g01.fujitsu.local
 (g01jpexchyt11.g01.fujitsu.local [10.128.194.50])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3598E1DB804B
 for <kexec@lists.infradead.org>; Wed, 31 Oct 2012 18:01:03 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH v3 2/2] KVM: make crash_clear_loaded_vmcss valid when
 loading kvm_intel module
Date: Wed, 31 Oct 2012 09:01:01 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E20AACCA2F@G01JPEXMBYT03>
References: <50909B55.2070901@cn.fujitsu.com> <50909C35.9080702@cn.fujitsu.com>
In-Reply-To: <50909C35.9080702@cn.fujitsu.com>
Content-Language: ja-JP
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei <zhangyanfei@cn.fujitsu.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avi Kivity <avi@redhat.com>



> -----Original Message-----
> From: kexec-bounces@lists.infradead.org
> [mailto:kexec-bounces@lists.infradead.org] On Behalf Of zhangyanfei
> Sent: Wednesday, October 31, 2012 12:34 PM
> To: x86@kernel.org; kexec@lists.infradead.org; Avi Kivity; Marcelo
> Tosatti
> Cc: linux-kernel@vger.kernel.org; kvm@vger.kernel.org
> Subject: [PATCH v3 2/2] KVM: make crash_clear_loaded_vmcss valid when
> loading kvm_intel module
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

[...]

> @@ -7230,6 +7231,10 @@ static int __init vmx_init(void)
>  	if (r)
>  		goto out3;
> 
> +#ifdef CONFIG_KEXEC
> +	crash_clear_loaded_vmcss = vmclear_local_loaded_vmcss;
> +#endif
> +

Assignment here cannot cover the case where NMI is initiated after VMX is on in kvm_init and before vmclear_local_loaded_vmcss is assigned, though rare but can happen.

What does happen if calling vmclear_local_loaded_vmcss before kvm_init? I think it no problem since the list is initially empty.

>  	vmx_disable_intercept_for_msr(MSR_FS_BASE, false);
>  	vmx_disable_intercept_for_msr(MSR_GS_BASE, false);
>  	vmx_disable_intercept_for_msr(MSR_KERNEL_GS_BASE, true);
> @@ -7265,6 +7270,10 @@ static void __exit vmx_exit(void)
>  	free_page((unsigned long)vmx_io_bitmap_b);
>  	free_page((unsigned long)vmx_io_bitmap_a);
> 
> +#ifdef CONFIG_KEXEC
> +	crash_clear_loaded_vmcss = NULL;
> +#endif
> +
>  	kvm_exit();
>  }

Also, this is converse to the above.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
