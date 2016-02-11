Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([125.16.236.6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTggi-0003IN-Hk
 for kexec@lists.infradead.org; Thu, 11 Feb 2016 02:08:57 +0000
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 11 Feb 2016 07:38:32 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B28RXF3735814
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 07:38:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B7c4Mv003072
 for <kexec@lists.infradead.org>; Thu, 11 Feb 2016 13:08:04 +0530
Message-ID: <1455156500.2538.268.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 19/22] ima: support for kexec image and initramfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Wed, 10 Feb 2016 21:08:20 -0500
In-Reply-To: <CACE9dm8OJ1cgbKszUG-pCiEMVarUFLLWi_jewVV-JEMGAJsA-g@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-20-git-send-email-zohar@linux.vnet.ibm.com>
 <CACE9dm9cqE5cu=0+LujHOGP9XyhGNxYfy52Ds6z+pz+fPwF+pw@mail.gmail.com>
 <1455146516.2538.237.camel@linux.vnet.ibm.com>
 <CACE9dm8OJ1cgbKszUG-pCiEMVarUFLLWi_jewVV-JEMGAJsA-g@mail.gmail.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <keescook@chromium.org>, fsdevel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

On Thu, 2016-02-11 at 01:55 +0200, Dmitry Kasatkin wrote:
> On Feb 11, 2016 1:22 AM, "Mimi Zohar" <zohar@linux.vnet.ibm.com> wrote:
> >
> > On Wed, 2016-02-10 at 23:09 +0200, Dmitry Kasatkin wrote:
> > > On Wed, Feb 3, 2016 at 9:06 PM, Mimi Zohar <zohar@linux.vnet.ibm.com>
> wrote:

> > > >
> > > > -       if (read_id == READING_FIRMWARE)
> > > > +       switch (read_id) {
> > > > +       case READING_FIRMWARE:
> > > >                 func = FIRMWARE_CHECK;
> > > > -       else if (read_id == READING_MODULE)
> > > > +               break;
> > > > +       case READING_MODULE:
> > > >                 func = MODULE_CHECK;
> > > > +               break;
> > > > +       case READING_KEXEC_IMAGE:
> > > > +               func = KEXEC_CHECK;
> > > > +               break;
> > > > +       case READING_KEXEC_INITRAMFS:
> > > > +               func = INITRAMFS_CHECK;
> > > > +               break;
> > > > +       default:
> > > > +               func = FILE_CHECK;
> > > > +               break;
> > > > +       }
> > > >
> > >
> > > I would define a separate function like "int ima_read_id_to_func(id)"
> > > which search over the map
> > >
> > > Something like...
> > >
> > > struct
> > > {
> > >      int id;
> > >      int func;
> > > }  map[] = {
> > >   { .id = READING_FIRMWARE, .fun = FIRMWARE_CHECK },
> > >    ...
> > >   { -1, 0 }
> > > };
> > >
> >
> > So we stay with the duplication (option 1), but clean it up.  That works
> > for me.
> >
> 
> Actually it may be simpler.
> Just define int idmap[MAX_ID] and assign to every id corresponding func.
> It will be quick and simple.

Unlike the ima_read_id_to_func() above or the original switch/case
statement, this method assumes the kernel_read_file_id enumeration stays
in sync with ima_hooks.  In terms of the  ima_read_id_to_func()
function, it would iterate over the map[] to find the corresponding .id,
whereas the current switch/case is a direct lookup.

Perhaps we should defer making a change for now.
  
Mimi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
