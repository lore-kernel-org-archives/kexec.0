Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TucOA-0002rp-0j
 for kexec@lists.infradead.org; Mon, 14 Jan 2013 05:15:16 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Mon, 14 Jan 2013 15:09:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A7D5F3578051
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2013 16:15:03 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0E5F22A61997256
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2013 16:15:03 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0E5F1MA023678
 for <kexec@lists.infradead.org>; Mon, 14 Jan 2013 16:15:01 +1100
Message-ID: <50F3944D.7080506@in.ibm.com>
Date: Mon, 14 Jan 2013 10:44:53 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] ppc/uImage: Add support for RAM Disks
References: <20130111063547.11490.28174.stgit@suzukikp.in.ibm.com>
 <20130111064203.11490.72998.stgit@suzukikp.in.ibm.com>
 <70CC66F5C30A414DADDA6973E4CA391A820296@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <70CC66F5C30A414DADDA6973E4CA391A820296@039-SN1MPN1-002.039d.mgd.msft.net>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: McClintock Matthew-B29882 <B29882@freescale.com>
Cc: "lethal@linux-sh.org" <lethal@linux-sh.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>, "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "mat@brain-dump.org" <mat@brain-dump.org>

On 01/11/2013 12:41 PM, McClintock Matthew-B29882 wrote:
> On Fri, Jan 11, 2013 at 12:42 AM, Suzuki K. Poulose <suzuki@in.ibm.com> wrote:
>> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>>
>> Handle the RAM Disks in uImage format
>
> As opposed to simple ext2.gz ramdisk?

Yep. Any supported ramdisk format can be wrapped up in a uImage file.

Thanks
Suzuki

>
> -M
>
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
>> ---
>>   kexec/arch/ppc/kexec-uImage-ppc.c |   22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
>> index eaea3c1..58935c0 100644
>> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
>> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
>> @@ -46,6 +46,26 @@ void uImage_ppc_usage(void)
>>          );
>>   }
>>
>> +char* slurp_ramdisk_ppc(const char *filename, off_t *r_size)
>> +{
>> +       struct Image_info img;
>> +       off_t size;
>> +       const unsigned char *buf =
>> +                       (const unsigned char *)slurp_file(filename, &size);
>> +
>> +       /* Check if this is a uImage RAMDisk */
>> +       if (buf != (void*)0 &&
>> +               uImage_probe(buf, size, IH_ARCH_PPC) == IH_TYPE_RAMDISK) {
>> +               if (uImage_load(buf, size, &img) != 0)
>> +                       die ("uImage: Reading %ld bytes from %s failed\n", size, filename);
>> +               buf = img.buf;
>> +               size = img.len;
>> +       }
>> +
>> +       *r_size = size;
>> +       return buf;
>> +}
>> +
>>   int uImage_ppc_probe(const char *buf, off_t len)
>>   {
>>          int type;
>> @@ -196,7 +216,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>>          blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, load_addr, &dtb_addr);
>>
>>          if (ramdisk) {
>> -               seg_buf = slurp_file(ramdisk, &seg_size);
>> +               seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
>>                  /* Load ramdisk at top of memory */
>>                  hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
>>                                  0, dtb_addr + blob_size, max_addr, -1);
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
