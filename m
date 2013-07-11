Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
 helo=ch1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UxPdV-0003W6-Mx
 for kexec@lists.infradead.org; Thu, 11 Jul 2013 22:46:54 +0000
Message-ID: <51DF35B8.1060502@mail.usask.ca>
Date: Thu, 11 Jul 2013 16:46:16 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
In-Reply-To: <51DF2229.5010604@mail.usask.ca>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, kexec@lists.infradead.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On 07/11/2013 03:22 PM, Chris Friesen wrote:
> On 07/11/2013 02:55 PM, Chris Friesen wrote:
>> Hi,
>>
>> I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
>> with 8GB of memory. (It's an embedded system and I can't do much
>> about the fact that it's using older software.)
>
> I should probably clarify this...I may be able to update kexec, I can't
> update the kernel but I can backport more recent code if necessary.
>
> Looking at the version of kexec that I have, it seems like where x86
> uses "memmap=" to specify the memory map usable by the capture kernel,
> powerpc does something different.

After some experimenting, it looks like in the capture kernel 
/dev/oldmem might actually refer to the memory owned by the old kernel.

However, there doesn't seem to be anything preventing me from trampling 
it from within the capture kernel--I can create a tmpfs filesystem in 
memory and write gigs of data to it even though the capture kernel is 
only supposed to have 224MB.

I think I got it to work properly once, but since then I haven't been 
able to get uncorrupted data out of /dev/oldmem.  (My original kernel 
reserves a chunk of memory for logging and passes the offset/size to the 
capture kernel via kexec kernel args.)

Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
