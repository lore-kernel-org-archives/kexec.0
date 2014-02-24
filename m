Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WI0tR-0000Cy-PF
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 19:08:46 +0000
Message-ID: <530B989B.8010507@zytor.com>
Date: Mon, 24 Feb 2014 11:08:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 07/11] kexec: Create a relocatable object called purgatory
References: <1390849071-21989-1-git-send-email-vgoyal@redhat.com>
 <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
In-Reply-To: <1390849071-21989-8-git-send-email-vgoyal@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, jkosina@suse.cz, ebiederm@xmission.com, greg@kroah.com

On 01/27/2014 10:57 AM, Vivek Goyal wrote:
> +
> +/**
> + * memcpy - Copy one area of memory to another
> + * @dest: Where to copy to
> + * @src: Where to copy from
> + * @count: The size of the area.
> + */
> +static void *memcpy(void *dest, const void *src, unsigned long count)
> +{
> +	char *tmp = dest;
> +	const char *s = src;
> +
> +	while (count--)
> +		*tmp++ = *s++;
> +	return dest;
> +}
> +
> +static int memcmp(const void *cs, const void *ct, size_t count)
> +{
> +	const unsigned char *su1, *su2;
> +	int res = 0;
> +
> +	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
> +		if ((res = *su1 - *su2) != 0)
> +			break;
> +	return res;
> +}
> +

<bikeshed>

There multiple implementations of memcpy(), memcmp() and memset() in
this patchset, and they make my eyes want to bleed (especially
memcmp()).  Can we centralize there, and perhaps even share code with
the stuff in arch/x86/boot already?

</bikeshed>

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
