Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UXtx5-0000W2-Fv
 for kexec@lists.infradead.org; Thu, 02 May 2013 13:53:40 +0000
Received: by mail-lb0-f172.google.com with SMTP id y6so541002lbh.31
 for <kexec@lists.infradead.org>; Thu, 02 May 2013 06:53:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEyr1FRheru84wGJeWqebT0k86zsj6HRZdFWC-1Rf7j7UY4ykg@mail.gmail.com>
References: <CAEyr1FRVjfoBshx+3FJeTZoVGJn61A5=EtbwZ-RGC4-w79Y_Dg@mail.gmail.com>
 <CAEyr1FRheru84wGJeWqebT0k86zsj6HRZdFWC-1Rf7j7UY4ykg@mail.gmail.com>
Date: Thu, 2 May 2013 19:23:15 +0530
Message-ID: <CAEyr1FRaLojajqqmTBKxVRDqV=XdGK3AR6SQ0LpMsK8xwz53Qw@mail.gmail.com>
Subject: Re: Unknown rel relocation: Error
From: Anand Raj Manickam <anandrm@gmail.com>
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
To: kexec@lists.infradead.org

On Wed, May 1, 2013 at 7:58 PM, Anand Raj Manickam <anandrm@gmail.com> wrote:
> Hi,
> While executing " kexec -l vmlinuz-2.6.30  "
> I get Unknown rel relocation: 9 error.
>
> I understand from the source that this is the mismatch of ELF TYPE ,
> which in my case is R_386_GOTOFF .
>
> Is there a known build tool dependency for kexec ?  I m using the 2.0.4 version.
>
> I m running this on AMD Athelon machine .
>
> Any help is appreciated .
>
> Thanks,
> Anand


Things work after i upgrade gcc-4.7.2 .
Is there a way to get rid of the gcc dependency , i m using 4.1.2.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
