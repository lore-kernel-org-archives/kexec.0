Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUDEb-0004DY-Lg
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 12:54:19 +0000
Date: Fri, 12 Feb 2016 20:53:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
Message-ID: <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

Hi, Mimi

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a5d2592..832e62a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -147,6 +147,8 @@ enum ima_hooks {
>  	POST_SETATTR,
>  	MODULE_CHECK,
>  	FIRMWARE_CHECK,
> +	KEXEC_CHECK,
> +	INITRAMFS_CHECK,

KEXEC_CHECK is actually kexec kernel image check, INITRAMFS_CHECK is for
kexec initramfs check, they are both for checking kexec loaded files.

Do you mind a longer id like KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK?

>  	MAX_CHECK
>  };
>  

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
