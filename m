Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJkpt-0006Mn-J3
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 13:52:02 +0000
Date: Wed, 11 Sep 2013 09:51:37 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 14/16] kexec: Export sysfs attributes for secureboot and
 secure modules to user space
Message-ID: <20130911135137.GC15364@redhat.com>
References: <1378849471-10521-1-git-send-email-vgoyal@redhat.com>
 <1378849471-10521-15-git-send-email-vgoyal@redhat.com>
 <CA+5PVA7seT-Au6Qsr-svbG38-ohCUrw2=W6CoO5XWqy2Avjg6A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+5PVA7seT-Au6Qsr-svbG38-ohCUrw2=W6CoO5XWqy2Avjg6A@mail.gmail.com>
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
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, d.kasatkin@samsung.com, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>

On Tue, Sep 10, 2013 at 06:57:55PM -0400, Josh Boyer wrote:

[..]
> > +static ssize_t secureboot_enabled_show(struct kobject *kobj,
> > +                                      struct kobj_attribute *attr, char *buf)
> > +{
> > +       /* TODO: Change it once secureboot patches are in */
> > +       return sprintf(buf, "%d\n", 1);
> > +}
> > +KERNEL_ATTR_RO(secureboot_enabled);
> 
> You're defaulting this to enabled, even on machines where SB isn't
> possible.  I realize there are TODOs there, but you might want to
> default it to off if you really intend this on going upstream before
> any of the other secure_* infrastructure does.

I defaulted it to 1 because I wanted to artificially simulate that
secureboot is enabled and make sure kexec-tools verifies signature
of bzImage.

This is just an RFC series to show what's cooking and get early feedback
about design. I am not expecting any of this to get in before secureboot/
secure_modules/securelevel patches get in.

First some set of patches need to block kexec loading, only then these
patches make sense.

So don't read too much into current default values. Idea is to show
that kernel will export 1-2 knobs to user space which will signal
kexec-tools to verify signature of bzImage and also set "secureboot"
in bootparams for next kernel as needed.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
