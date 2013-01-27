Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TzVGq-0007AW-2I
 for kexec@lists.infradead.org; Sun, 27 Jan 2013 16:39:53 +0000
Message-ID: <51055846.4040200@linutronix.de>
Date: Sun, 27 Jan 2013 17:39:34 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
 <20130116172601.GB20369@linutronix.de> <50F7C8A7.4000100@in.ibm.com>
In-Reply-To: <50F7C8A7.4000100@in.ibm.com>
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
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: lethal@linux-sh.org, horms@verge.net.au, kexec@lists.infradead.org, mat@brain-dump.org

On 01/17/2013 10:47 AM, Suzuki K. Poulose wrote:
>>> +{
>>> +    struct Image_info img;
>>> +    off_t size;
>>> +    const unsigned char *buf =
>>> +            (const unsigned char *)slurp_file(filename, &size);
>>
>> is the const cast required here?
> 
> Yes, the uImage_probe() expects (const unsigned char *) as the first
> argument.

That is okay, you can pass a non-const pointer to function that expects
a const pointer. You just can't pass a const pointer to a non-const
function and you should not cast in that situtation as well.

>>> +        buf = img.buf;
>>> +        size = img.len;
>>> +    }
>>> +
>>> +    *r_size = size;
>>> +    return buf;
>>> +}
>>> +   
>>> int uImage_ppc_probe(const char *buf, off_t len)
>>> {
>>>     int type;
>>> @@ -196,7 +216,7 @@ static int ppc_load_bare_bits(int argc, char
>>> **argv, const char *buf,
>>>     blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr,
>>> &dtb_addr);
>>>
>>>     if (ramdisk) {
>>> -        seg_buf = slurp_file(ramdisk, &seg_size);
>>> +        seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
>>
>> I'm not sure but this kinda breaks the case where someone was using a
>> plain file without the uImage header. I don't know if someone used this
>> at all but it seems we have code for this. The way you load the uImage
>> is very generic and I would expect to load it the same way on ARM or SH.
>>
> If the ramdisk doesn't have uImage header, the slurp_ramdisk_ppc()
> defaults to the original behaviour. i.e, it just does a slurp_file()
> as it used to do earlier.
that is okay then.

>> One thing that is different compared to kernel: If the compression is
>> set to GZ on a ramdisk image you should not uncompress it. I think that
>> uImage_load() decompresses the .gz part for you but I am not sure.
>>
> 
> Did you mean, uImage_load() shouldn't do a decompression for ramdisk ?

Yes. If you look at u-boot source, you will notice that it will
decompress a kernel if it is gzip/bzip2/whatever compressed and ignore
the compression field in case of a ramdisk. I think you should behave
like u-boot does.

Sebastian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
