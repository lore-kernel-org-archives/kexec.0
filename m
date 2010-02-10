Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NfHZq-00032z-Bh
	for kexec@lists.infradead.org; Wed, 10 Feb 2010 18:46:23 +0000
Received: by pxi39 with SMTP id 39so185313pxi.2
	for <kexec@lists.infradead.org>; Wed, 10 Feb 2010 10:46:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B6D393A.7060103@bwalle.de>
References: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
	<4B6D393A.7060103@bwalle.de>
Date: Wed, 10 Feb 2010 10:46:15 -0800
Message-ID: <74ae4f6a1002101046y5faeacebxdf822eac8ccf6c98@mail.gmail.com>
Subject: Re: kdump cp /proc/vmcore exiting with "Invalid Argument" Error
From: Sujit V <sujit.linux@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bernhard@bwalle.de>, SUJIT V <sujit.linux@gmail.com>
Cc: fastboot@lists.linux-foundation.org, kexec@lists.infradead.org

Tried readelf on the /proc/vmcore but gave the below error. The
readelf worked correctly on another binary.

kdump shell>/sbin/readelf -l /proc/vmcore
readelf: Error: Cannot stat input file /proc/vmcore.


Anything else I could try.?


On Sat, Feb 6, 2010 at 1:41 AM, Bernhard Walle <bernhard@bwalle.de> wrote:
>
>
>
> Am 06.02.2010 03:45, schrieb Sujit V:
>> I have integrated the kdump in our linux 2.6.23 based kernel. If I do
>> echo c > /proc/sysrq-trigger then it boots the kdump kernel & I use
>> the cp /proc/vmcore /local/crash/vmcore-incomplete
>>
>> On a new x86 based hardware (32 bit PAE kernel) =A0the "cp /proc/vmcore
>> " command exits prematurely.
>>
>> cp -v /proc/vmcore /local/crash/vmcore-incomplete
>> =A0 =A0 =A0 cp: reading `/proc/vmcore': Invalid argument =A0>>> Error >>
>>
>> ls -l /local/crash/
>> total 115588
>> -r-------- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A02526724096 Feb =A0=
5 03:09 vmcore-incomplete
>>
>> ls -l /proc/vmcore
>> -r-------- =A0 =A01 0 =A0 =A0 =A0 =A00 =A0 =A0 =A0 =A04153763584 Feb =A0=
5 03:16 /proc/vmcore
>>
>>
>> Every time I trigger kdump the cp command exits after copying
>> 2526724096 bytes. So I thought it might be a file size issue.
>> Googling pointed out a patch in include/linux/proc_fs.h
>
> I would compare 'readelf -l /proc/vmcore' (ELF program headers) and map
> the file offset 2526724096 to the physical memory that belongs to that
> file offset. Maybe accessing that physical memory fails for some reason.
>
>> struct vmcore {
>> struct list_head list;
>> unsigned long long paddr;
>> - unsigned long size;
>> + unsigned long long size;
>> loff_t offset;
>>
>> I checked my kernel & it already has this patch.
>
> I don't think that this is the problem because 2526724096 is between 2G
> and 4G, so it doesn't point to some "magic border".
>
>
> Regards,
> Bernhard
>
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
