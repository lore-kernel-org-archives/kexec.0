Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c2gEd-0007Im-D7
 for kexec@lists.infradead.org; Fri, 04 Nov 2016 15:16:52 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
Date: Fri, 04 Nov 2016 10:13:39 -0500
In-Reply-To: <20161104073840.GD4314@x1> (Baoquan He's message of "Fri, 4 Nov
 2016 15:38:40 +0800")
Message-ID: <871syrcm70.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
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
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Baoquan He <bhe@redhat.com> writes:

> On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
>> Hello,
>> 
>> The kexec_file code currently builds the purgatory as a partially linked object 
>> (using ld -r). Is there a particular reason to use that instead of a position 
>> independent executable (PIE)?
>
> It's taken as "-r", relocatable in user space kexec-tools too originally.
> I think Vivek just keeps it the same when moving into kernel.

At least on x86 using just -r removed the need for a GOT and all of the
other nasty dynamic relocatable bits, that are not needed when the you
don't want to share your text bits with the page cache.

I can see reaons for refactoring code but I expect PIE expecutables need
a GOT and all of that pain in the neck stuff that can just be avoided by
building the code to run at an absolute address.

So far I have not seen ELF relocations that are difficult to process.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
