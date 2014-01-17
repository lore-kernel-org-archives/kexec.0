Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W4Dlf-0001Le-3G
 for kexec@lists.infradead.org; Fri, 17 Jan 2014 18:03:44 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20140109153703.GE25897@redhat.com> <87a9eyaumi.fsf@xmission.com>
 <20140116151301.GB6156@redhat.com> <87fvonwlri.fsf@xmission.com>
 <20140117140347.GB24394@redhat.com>
Date: Fri, 17 Jan 2014 10:03:10 -0800
In-Reply-To: <20140117140347.GB24394@redhat.com> (Vivek Goyal's message of
 "Fri, 17 Jan 2014 09:03:47 -0500")
Message-ID: <87zjmubi5d.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: Query regarding ELF loader arg style
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Vivek Goyal <vgoyal@redhat.com> writes:

> On Thu, Jan 16, 2014 at 03:27:13PM -0800, Eric W. Biederman wrote:
>
> [..]
>> > - ELF does not tell anything whether it is self relocating or not. So we
>> >   are forced to load it at a address it has been compiled for (In case of
>> >   kdump). And that address is already occupied by current running kernel
>> >   so it does not work.
>> 
>> ELF does tell you if it is relocatable in the e_type field of the main
>> elf header.  In particular ET_DYN vs ET_EXEC.  ET_DYN can be loaded
>> anywhere, and ET_EXEC must be loaded at the specified address.  It would
>> not surprise me if the kernel build process is using ET_EXEC in error.
>> 
>> ET_DYN is also what is used for PIE executables and shared libraires.
>> 
>> The rule with ET_DYN without a dynamic linker is that a constant offset
>> must be added to the load address of all of the program segments but
>> otherwise nothing changes.  I thought I had support for that form in
>> kexec-tools.
>> 
>> Perhaps not.
>
> Hi Eric,
>
> Kexec-tools supports ET_DYN. I saw code for that. Current kernel vmlinux
> is ET_EXEC though and expects to be loaded at the address for it has been
> compiled for.
>
> I think in intial version of patches I will just support ET_EXEC and then
> support for ET_DYN can be added later. It should really be simple as  all
> the core structure to find a memory hole and load buffers there will
> already be present. And at that time one can look into converting vmlinux
> to a ET_DYN instead of ET_EXEC.

Sounds good.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
