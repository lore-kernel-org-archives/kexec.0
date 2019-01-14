Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f67.google.com ([209.85.166.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gisvH-00010T-AI
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 03:28:25 +0000
Received: by mail-io1-f67.google.com with SMTP id s22so16573323ioc.8
 for <kexec@lists.infradead.org>; Sun, 13 Jan 2019 19:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20190109164824.19708-1-kasong@redhat.com>
 <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com>
 <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
From: Kairui Song <kasong@redhat.com>
Date: Mon, 14 Jan 2019 11:28:10 +0800
Message-ID: <CACPcB9caE8Go+MuayBe_Pzz+iHSRi0rr1-Yo1Qtbks=h5+fN1A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: jwboyer@fedoraproject.org, Eric Biggers <ebiggers@google.com>, Dave Young <dyoung@redhat.com>, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity <linux-integrity@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, bauerman@linux.ibm.com, serge@hallyn.com

Hi, Mimi, Dave

I checked the previous patches:
https://www.spinics.net/lists/keyrings/msg03518.html
https://www.spinics.net/lists/keyrings/msg03517.html
https://www.spinics.net/lists/keyrings/msg03516.html

That the latest patched I could found that placed the platform keyring in certs/
However it didn't cc kexec list, and so I think Dave didn't receive them.

I could compose a patch to use the previous design, how do you think?


On Sun, Jan 13, 2019 at 9:40 AM Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > [snip]
> >
> > > Personally I would like to see platform key separated from integrity.
> > > But for the kexec_file part I think it is good at least it works with
> > > this fix.
> > >
> > > Acked-by: Dave Young <dyoung@redhat.com>
> >
> > The original "platform" keyring patches that Nayna posted multiple
> > times were in the certs directory, but nobody commented/responded.  So
> > she reworked the patches, moving them to the integrity directory and
> > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > asking to move it, isn't it?
>
> Hmm, apologize for being late,  I did not get chance to have a look the
> old series.  Since we have the needs now, it should be still fine
>
> Maybe Kairui can check Nayna's old series, see if he can do something
> again?
>
> >
> > Mimi
> >
>
> Thanks
> Dave



--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
