Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aSt7A-0005oI-PE
 for kexec@lists.infradead.org; Mon, 08 Feb 2016 21:12:57 +0000
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 02:42:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u18LCNqF18350434
 for <kexec@lists.infradead.org>; Tue, 9 Feb 2016 02:42:24 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u18LCNu6018568
 for <kexec@lists.infradead.org>; Tue, 9 Feb 2016 02:42:26 +0530
Message-ID: <1454965936.3037.34.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 20/22] ima: load policy using path
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2016 16:12:16 -0500
In-Reply-To: <C2D7A727C393B644B70DF4B4DCFB60B9C8A882@lhreml507-mbx.china.huawei.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-21-git-send-email-zohar@linux.vnet.ibm.com>
 <20160207195945.GG17321@localhost>
 <C2D7A727C393B644B70DF4B4DCFB60B9C8A843@lhreml507-mbx.china.huawei.com>
 ,<20160208103505.GA7931@bender.nucleusys.com>
 <C2D7A727C393B644B70DF4B4DCFB60B9C8A882@lhreml507-mbx.china.huawei.com>
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
To: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Petko Manolov <petkan@mip-labs.com>, Kees Cook <keescook@chromium.org>, "fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dmitry Kasatkin <d.kasatkin@samsung.com>, David Woodhouse <dwmw2@infradead.org>, "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>

On Mon, 2016-02-08 at 10:45 +0000, Dmitry Kasatkin wrote:

> > > @@ -286,9 +322,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
> > >       result = mutex_lock_interruptible(&ima_write_mutex);
> > >       if (result < 0)
> > >               goto out_free;
> > > -     result = ima_parse_add_rule(data);
> > > -     mutex_unlock(&ima_write_mutex);
> > >
> > > +     if (data[0] == '/')
> >
> > >It seems that if we feed relative path to ima_policy the update will fail...
> >
> > Yes, i think it is always a good idea to pass absolute path.
> 
> What if we at least emit a warning so people know what's wrong?

The next patch "ima: measure and appraise the IMA policy itself" adds
the following.  Is a failure message enough?

+       else if (ima_appraise & IMA_APPRAISE_POLICY) {
+               pr_err("IMA: signed policy required\n");
+               integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+                                   "policy_update", "signed policy
required",
+                                   1, 0);
+               if (ima_appraise & IMA_APPRAISE_ENFORCE)
+                       result = -EACCES;
+       } else
                result = ima_parse_add_rule(data);

> 
>                 Petko
> 
> DK: May be a good idea to print that loading policy by path or not.

Are we including the pathname?  Are you suggesting a log or audit
message?

Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
