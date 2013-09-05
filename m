Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VHVF7-0003fO-Ms
 for kexec@lists.infradead.org; Thu, 05 Sep 2013 08:48:46 +0000
Date: Thu, 5 Sep 2013 16:48:20 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] kexec: x86: struct x86_linux_param_header should be packed
Message-ID: <20130905084820.GB11609@dhcp12-158.nay.redhat.com>
References: <20130805173510.GD2274@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130805173510.GD2274@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On 08/05/13 at 01:35pm, Vivek Goyal wrote:
> I think struct x86_linux_param_header should be packed. Strange that we
> did not do it so far. 
> 
> Without packing struct size was 3824 (decimal) on my x86_64 machine. With
> packing it is 3820. I think there was a padding of 4 bytes at the end. So
> it should be harmless.
> 
> I tried to introduce more fields and that introduced padding in the
> middle of structure and kexec stopped working and that's how I got to
> know that bootparam is not packed.

In this case that's true and x86_linux_param_header should be packed.

One more thing is,
in include/x86/x86-linux.h, we already define PACKED macro:
 #define PACKED __attribute__((packed))
But within x86-linux.h, both PACKED_and __attribute__((packed)) are used.

PACKED isn't used much time and __attribute__((packed)) is quite simple
and straightforward. Maybe it's time we can remove the macro and use
__attribute__((packed)) directly.

I can send another patch to address this if anyone thinks it's a good
idea.

Thanks
WANG Chao

> ---
>  include/x86/x86-linux.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: kexec-tools/include/x86/x86-linux.h
> ===================================================================
> --- kexec-tools.orig/include/x86/x86-linux.h	2013-08-05 13:28:33.999338740 -0400
> +++ kexec-tools/include/x86/x86-linux.h	2013-08-05 13:28:46.616475104 -0400
> @@ -198,7 +198,7 @@ struct x86_linux_param_header {
>  	struct 	edd_info eddbuf[EDDMAXNR];	/* 0xd00 */
>  						/* 0xeec */
>  #define COMMAND_LINE_SIZE 2048
> -};
> +} __attribute__ ((packed));
>  
>  struct x86_linux_faked_param_header {
>  	struct x86_linux_param_header hdr;	/* 0x00 */
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
