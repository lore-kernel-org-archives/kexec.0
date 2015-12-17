Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-db3on0140.outbound.protection.outlook.com
 ([157.55.234.140] helo=emea01-db3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a9TRK-0002Ug-SE
 for kexec@lists.infradead.org; Thu, 17 Dec 2015 07:57:32 +0000
Subject: Re: [PATCH] arm: ramdisk uimage support for arm
References: <56711B8C.9090407@powersoft.it>
 <20151217042353.GC1525@dhcppc13.redhat.com>
From: Michele Dionisio <michele.dionisio@powersoft.it>
Message-ID: <56726ADA.1050403@powersoft.it>
Date: Thu, 17 Dec 2015 08:57:14 +0100
MIME-Version: 1.0
In-Reply-To: <20151217042353.GC1525@dhcppc13.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: kexec@lists.infradead.org

yes it is true.

I'm not in the position to test ppc. So my only way to be sure to avoid 
to introduce regration is to avoid to refactor the code.

But it is true. If you are able to test ppc I can try to post the 
refactoring.

Il 17/12/2015 05:23, Pratyush Anand ha scritto:
> Hi Michele,
>
> On 16/12/2015:09:06:36 AM, Michele Dionisio wrote:
>> +/*
>> + * Load the ramdisk into buffer.
>> + *  If the supplied image is in uImage format use
>> + *  uImage_load() to read the payload from the image.
>> + */
>> +char *slurp_ramdisk_arm(const char *filename, off_t *r_size)
> This function is exactly as slurp_ramdisk_ppc(). So, why not we have a common
> slurp_ramdisk() function usable for both arm and ppc.
>
> ~Pratyush
> .
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
