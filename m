Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbGK3-0000HT-Ch
 for kexec@lists.infradead.org; Wed, 21 Nov 2012 19:51:00 +0000
Received: by mail-bk0-f49.google.com with SMTP id jm19so1891390bkc.36
 for <kexec@lists.infradead.org>; Wed, 21 Nov 2012 11:50:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121121145023.GD13114@redhat.com>
References: <1353483098-14883-1-git-send-email-yinghai@kernel.org>
 <1353483098-14883-5-git-send-email-yinghai@kernel.org>
 <20121121145023.GD13114@redhat.com>
Date: Wed, 21 Nov 2012 11:50:56 -0800
Message-ID: <CAE9FiQUHapB8_uGwMtM84xOHpMvWmVbn2Z8h0C=n_rfHPCbY_g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kexec, x86_64: Load bzImage64 above 4G
From: Yinghai Lu <yinghai@kernel.org>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Nov 21, 2012 at 6:50 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Tue, Nov 20, 2012 at 11:31:38PM -0800, Yinghai Lu wrote:
>
> [..]
>> +int bzImage64_probe(const char *buf, off_t len)
>> +{
>> +     const struct x86_linux_header *header;
>> +     if ((uintmax_t)len < (uintmax_t)(2 * 512)) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "File is too short to be a bzImage!\n");
>> +             }
>> +             return -1;
>> +     }
>> +     header = (const struct x86_linux_header *)buf;
>> +     if (memcmp(header->header_magic, "HdrS", 4) != 0) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "Not a bzImage\n");
>> +             }
>> +             return -1;
>> +     }
>> +     if (header->boot_sector_magic != 0xAA55) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "No x86 boot sector present\n");
>> +             }
>> +             /* No x86 boot sector present */
>> +             return -1;
>> +     }
>> +     if (header->protocol_version < 0x020C) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "Must be at least protocol version 2.12\n");
>> +             }
>> +             /* Must be at least protocol version 2.12 */
>> +             return -1;
>> +     }
>> +     if ((header->loadflags & 1) == 0) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "zImage not a bzImage\n");
>> +             }
>> +             /* Not a bzImage */
>> +             return -1;
>> +     }
>> +     if (!(header->xloadflags & 1)) {
>> +             if (probe_debug) {
>> +                     fprintf(stderr, "Not a bzImage64\n");
>> +             }
>> +             /* Must be LOADED_ABOVE_4G */
>> +             return -1;
>> +     }
>
> So how do I force a 16bit or 32bit entry using a bzImage64?

kexec -t bzImage -l ....
will load low and use 32bit entry.

kexec -t bzImage64 -l ...
kexec -l ...
will try to load high and use 64bit entry.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
