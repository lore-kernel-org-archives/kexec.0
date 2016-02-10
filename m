Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTdyw-0002FN-Vb
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 23:15:35 +0000
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 09:15:09 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2737C3578057
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:15:04 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1ANEtxm40829020
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:15:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1ANEV2O022119
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 10:14:31 +1100
Message-ID: <1455146051.2538.230.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 17/22] ima: remove firmware and module specific
 cached status info
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 18:14:11 -0500
In-Reply-To: <CACE9dm9dmwfPN_C+kL-ys4TQKDHvyvYuqQKVLbS1=ERju8Z5Lw@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-18-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm9dmwfPN_C+kL-ys4TQKDHvyvYuqQKVLbS1=ERju8Z5Lw@mail.gmail.com>
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
To: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R.
 Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Wed, 2016-02-10 at 22:18 +0200, Dmitry Kasatkin wrote:

> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index cb0d0ff..6b4694a 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -74,13 +74,12 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> >                 return iint->ima_mmap_status;
> >         case BPRM_CHECK:
> >                 return iint->ima_bprm_status;
> > -       case MODULE_CHECK:
> > -               return iint->ima_module_status;
> > -       case FIRMWARE_CHECK:
> > -               return iint->ima_firmware_status;
> >         case FILE_CHECK:
> > -       default:
> > +       case POST_SETATTR:
> >                 return iint->ima_file_status;
> > +       case MODULE_CHECK ... MAX_CHECK - 1:
> 
> Will LLVM clang handles this range?
> 
> Otherwise it can be just like:
> 
> case MODULE_CHECK ... MAX_CHECK :

Yes, my test program compiled fine with clang.  Similar usage exists in
the kernel (eg. fs/afs/callback.c).

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
