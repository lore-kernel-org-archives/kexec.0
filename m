Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjRta-0002By-Er
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 16:49:00 +0000
Received: by mail-it1-f196.google.com with SMTP id h65so5271983ith.3
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 08:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20190115094542.17129-1-kasong@redhat.com>
 <20190115094542.17129-3-kasong@redhat.com>
 <1547567218.4156.289.camel@linux.ibm.com>
In-Reply-To: <1547567218.4156.289.camel@linux.ibm.com>
From: Kairui Song <kasong@redhat.com>
Date: Wed, 16 Jan 2019 00:48:46 +0800
Message-ID: <CACPcB9e+TWK7s5ud_yNd4EiuFyM5hctAMqBSnOZzL3g03ryr_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] kexec, KEYS: Make use of platform keyring for
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

On Tue, Jan 15, 2019 at 11:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
>
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> > index 7d97e432cbbc..a06b04065bb1 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -534,9 +534,18 @@ static int bzImage64_cleanup(void *loader_data)
> >  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
> >  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
> >  {
> > -     return verify_pefile_signature(kernel, kernel_len,
> > -                                    VERIFY_USE_SECONDARY_KEYRING,
> > -                                    VERIFYING_KEXEC_PE_SIGNATURE);
> > +     int ret;
> > +     ret = verify_pefile_signature(kernel, kernel_len,
> > +                     VERIFY_USE_SECONDARY_KEYRING,
> > +                     VERIFYING_KEXEC_PE_SIGNATURE);
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
>
> Consider using IS_ENABLED() or IS_BUILTIN().
>
> Mimi

Thanks for the suggestion, will update the patch later if there are no
other comments.

>
> > +     if (ret == -ENOKEY) {
> > +             ret = verify_pefile_signature(kernel, kernel_len,
> > +                             VERIFY_USE_PLATFORM_KEYRING,
> > +                             VERIFYING_KEXEC_PE_SIGNATURE);
> > +     }
> > +#endif
> > +     return ret;
> >  }
> >  #endif
>



--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
