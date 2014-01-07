Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0OCS-0005V3-RK
 for kexec@lists.infradead.org; Tue, 07 Jan 2014 04:23:33 +0000
Message-ID: <52CB8118.30601@zytor.com>
Date: Mon, 06 Jan 2014 20:22:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/6] kexec: A new system call, kexec_file_load, for in
 kernel kexec
References: <20131121191907.GA26366@srcf.ucam.org>	<20131122185706.GK4046@redhat.com>	<87vbzju6ql.fsf@xmission.com>	<20131125163920.GC23094@redhat.com>	<87fvqj2vxz.fsf@xmission.com>	<20131126142759.GA5473@redhat.com>	<20131219125439.GA6379@lst.de>	<20131220141917.GB27063@redhat.com>	<87a9fvqfs4.fsf@xmission.com>	<CAGXu5jKJ88J-++nvkPVvghkXbN+_mB=T1siSDF7yoXQ-d-ONxg@mail.gmail.com>	<20140102203912.GB22822@redhat.com>	<52C5D28F.6030008@zytor.com>
 <CA+5PVA60FLTXZxf1hVuzD=_vUdg10Y7sYG9iZCs4voxurV_t0g@mail.gmail.com>
In-Reply-To: <CA+5PVA60FLTXZxf1hVuzD=_vUdg10Y7sYG9iZCs4voxurV_t0g@mail.gmail.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kees Cook <keescook@chromium.org>, Greg KH <greg@kroah.com>, kexec <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Peter Jones <pjones@redhat.com>, Torsten Duwe <duwe@lst.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/06/2014 01:33 PM, Josh Boyer wrote:
> On Thu, Jan 2, 2014 at 3:56 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 01/02/2014 12:39 PM, Vivek Goyal wrote:
>>>
>>> If secureboot is enabled, it enforces module signature verification. I
>>> think similar will happen for kexec too. How would kernel know that on
>>> a secureboot platform fd original verification will happen and it is
>>> sufficient.
>>>
>>> I personally want to support bzImage as well (apart from ELF) because
>>> distributions has been shipping bzImage for a long time and I don't
>>> want to enforce a change there because of secureboot. It is not necessary.
>>> Right now I am thinking more about storing detached bzImage signatures
>>> and passing those signatures to kexec system call.
>>>
>>
>> Since the secureboot scenario probably means people will be signing
>> those kernels, and those kernels are going to be EFI images, that in
>> order to have "one kernel, one signature" there will be a desire to
>> support signed PE images.  Yes, PE is ugly but it shouldn't be too bad.
>>  However, it is probably one of those things that can be dealt with one
>> bit at a time.
> 
> David Howells posted patches to support signed PE binaries early last
> year.  They were rejected rather quickly.
> 
> https://lkml.org/lkml/2013/2/21/196
> 
> That was for loading keys via PE binaries, but the parser is needed
> either way.  Unless I'm misunderstanding what you're suggesting?
> 

I know.  I think the kexec is a better motivation, though.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
