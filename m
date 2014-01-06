Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ob0-x22e.google.com ([2607:f8b0:4003:c01::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0HoO-0005fi-Hp
 for kexec@lists.infradead.org; Mon, 06 Jan 2014 21:34:18 +0000
Received: by mail-ob0-f174.google.com with SMTP id wn1so19029061obc.33
 for <kexec@lists.infradead.org>; Mon, 06 Jan 2014 13:33:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52C5D28F.6030008@zytor.com>
References: <20131121191907.GA26366@srcf.ucam.org>
 <20131122185706.GK4046@redhat.com> <87vbzju6ql.fsf@xmission.com>
 <20131125163920.GC23094@redhat.com> <87fvqj2vxz.fsf@xmission.com>
 <20131126142759.GA5473@redhat.com> <20131219125439.GA6379@lst.de>
 <20131220141917.GB27063@redhat.com> <87a9fvqfs4.fsf@xmission.com>
 <CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>
 <20140102203912.GB22822@redhat.com> <52C5D28F.6030008@zytor.com>
Date: Mon, 6 Jan 2014 16:33:52 -0500
Message-ID: <CA+5PVA60FLTXZxf1hVuzD=_vUdg10Y7sYG9iZCs4voxurV_t0g@mail.gmail.com>
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
From: Josh Boyer <jwboyer@fedoraproject.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Jan 2, 2014 at 3:56 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 01/02/2014 12:39 PM, Vivek Goyal wrote:
>>
>> If secureboot is enabled, it enforces module signature verification. I
>> think similar will happen for kexec too. How would kernel know that on
>> a secureboot platform fd original verification will happen and it is
>> sufficient.
>>
>> I personally want to support bzImage as well (apart from ELF) because
>> distributions has been shipping bzImage for a long time and I don't
>> want to enforce a change there because of secureboot. It is not necessary.
>> Right now I am thinking more about storing detached bzImage signatures
>> and passing those signatures to kexec system call.
>>
>
> Since the secureboot scenario probably means people will be signing
> those kernels, and those kernels are going to be EFI images, that in
> order to have "one kernel, one signature" there will be a desire to
> support signed PE images.  Yes, PE is ugly but it shouldn't be too bad.
>  However, it is probably one of those things that can be dealt with one
> bit at a time.

David Howells posted patches to support signed PE binaries early last
year.  They were rejected rather quickly.

https://lkml.org/lkml/2013/2/21/196

That was for loading keys via PE binaries, but the parser is needed
either way.  Unless I'm misunderstanding what you're suggesting?

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
