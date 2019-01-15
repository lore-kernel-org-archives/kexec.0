Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io1-f65.google.com ([209.85.166.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQwS-0001XV-3E
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 15:47:53 +0000
Received: by mail-io1-f65.google.com with SMTP id f4so2430089ion.2
 for <kexec@lists.infradead.org>; Tue, 15 Jan 2019 07:47:51 -0800 (PST)
MIME-Version: 1.0
References: <20190115094542.17129-1-kasong@redhat.com>
 <20190115094542.17129-2-kasong@redhat.com>
 <1547566455.4156.283.camel@linux.ibm.com>
In-Reply-To: <1547566455.4156.283.camel@linux.ibm.com>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 15 Jan 2019 23:47:39 +0800
Message-ID: <CACPcB9fQUNiD8UEVDa+bU67PZSOkckwhwD00Qvu4m3G0JmqqHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] integrity,
 KEYS: add a reference to platform keyring
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

On Tue, Jan 15, 2019 at 11:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Tue, 2019-01-15 at 17:45 +0800, Kairui Song wrote:
> [snip]
>
> > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > index f45d6edecf99..bfabc2a8111d 100644
> > --- a/security/integrity/digsig.c
> > +++ b/security/integrity/digsig.c
> > @@ -89,6 +89,12 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
> >               keyring[id] = NULL;
> >       }
> >
> > +#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
> > +     if (id == INTEGRITY_KEYRING_PLATFORM) {
> > +             set_platform_trusted_keys(keyring[id]);
> > +     }
> > +#endif
> > +
> >       return err;
> >  }
> >
>
> Any reason for setting it here as opposed to in the caller
> platform_keyring_init()?
>
> Mimi
>

Yes, "keyring" is static so unless I expose it to other files, it is
only accessible here. And I think there should be no problem to put
the set_platform_trusted_keys here.

-- 
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
