Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by casper.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PXUB3-0003J7-VD
	for kexec@lists.infradead.org; Tue, 28 Dec 2010 07:41:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <4D18F798.4010708@zytor.com> <20101228000651.GB4142@redhat.com>
	<4D192BC3.8040802@zytor.com>
Date: Mon, 27 Dec 2010 23:40:08 -0800
In-Reply-To: <4D192BC3.8040802@zytor.com> (H. Peter Anvin's message of "Mon,
	27 Dec 2010 16:13:55 -0800")
Message-ID: <m1lj3auyzr.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: How does kdump deal with trampoline allocation?
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 12/27/2010 04:06 PM, Vivek Goyal wrote:
>> On Mon, Dec 27, 2010 at 12:31:20PM -0800, H. Peter Anvin wrote:
>>> Hi guys,
>>>
>>> I'm planning a major overhaul of the trampoline allocation in x86, and
>>> I'm trying to understand how kdump deals with it.  The trampoline has to
>>> be allocated in low memory (< 1 MiB) and obviously that doesn't include
>>> the kdump area at all.
>> 
>> Hi Peter,
>> 
>> Kdump has the concept of backup area. We backup the contents of first
>> 640KB of physical RAM in kdump reserved area and then allow kdump kernel
>> to use first 640KB of memory. So any trampoline allocation can be done
>> in low memory area without overwritting the contents of first kernel.
>> 
>
> OK, that's straightforward.  That presumably means that the low 640K is
> marked unused in the memory map that memblock sees during early startup.
>  That fits very cleanly with the patches I'm doing.

Additionally we typically start with maxcpus=1 so we don't strictly
need the trampoline to start other cpus.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
