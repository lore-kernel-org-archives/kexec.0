Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUDeH-0002b1-57
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 13:20:37 +0000
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Fri, 12 Feb 2016 23:10:06 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 031362BB0057
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:10:02 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CD9luf49938618
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:09:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CD9TlA026320
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:09:29 +1100
Message-ID: <1455282548.2544.22.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 12 Feb 2016 08:09:08 -0500
In-Reply-To: <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
 <20160212125333.GC7051@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Fri, 2016-02-12 at 20:53 +0800, Dave Young wrote:
> Hi, Mimi
> 
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > index a5d2592..832e62a 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -147,6 +147,8 @@ enum ima_hooks {
> >  	POST_SETATTR,
> >  	MODULE_CHECK,
> >  	FIRMWARE_CHECK,
> > +	KEXEC_CHECK,
> > +	INITRAMFS_CHECK,
> 
> KEXEC_CHECK is actually kexec kernel image check, INITRAMFS_CHECK is for
> kexec initramfs check, they are both for checking kexec loaded files.
> 
> Do you mind a longer id like KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK?

These are the IMA policy tokens.  Currently the IMA policy would include
these KEXEC rules, where "appraise_type=imasig" indicates requiring a
signature as opposed to a hash.

measure func=KEXEC_CHECK
appraise func=KEXEC_CHECK appraise_type=imasig
#
measure func=INITRAMFS_CHECK
appraise func=INITRAMFS_CHECK appraise_type=imasig

I'll change these IMA policy identifiers to the longer names you
suggested.

thanks,

Mimi

> >  	MAX_CHECK
> >  };
> >  
> 
> Thanks
> Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
