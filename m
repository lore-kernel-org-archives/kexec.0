Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UXY1I-00057t-4V
 for kexec@lists.infradead.org; Wed, 01 May 2013 14:28:33 +0000
Received: by mail-lb0-f170.google.com with SMTP id r10so1506463lbi.1
 for <kexec@lists.infradead.org>; Wed, 01 May 2013 07:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEyr1FRVjfoBshx+3FJeTZoVGJn61A5=EtbwZ-RGC4-w79Y_Dg@mail.gmail.com>
References: <CAEyr1FRVjfoBshx+3FJeTZoVGJn61A5=EtbwZ-RGC4-w79Y_Dg@mail.gmail.com>
Date: Wed, 1 May 2013 19:58:10 +0530
Message-ID: <CAEyr1FRheru84wGJeWqebT0k86zsj6HRZdFWC-1Rf7j7UY4ykg@mail.gmail.com>
Subject: Fwd: Unknown rel relocation: Error
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

Hi,
While executing " kexec -l vmlinuz-2.6.30  "
I get Unknown rel relocation: 9 error.

I understand from the source that this is the mismatch of ELF TYPE ,
which in my case is R_386_GOTOFF .

Is there a known build tool dependency for kexec ?  I m using the 2.0.4 version.

I m running this on AMD Athelon machine .

Any help is appreciated .

Thanks,
Anand

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
