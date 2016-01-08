Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aHX5l-0008Jk-Oy
 for kexec@lists.infradead.org; Fri, 08 Jan 2016 13:28:34 +0000
Subject: Re: [PATCH v3 2/2] kexec: Provide
 arch_kexec_protect(unprotect)_crashkres()
References: <1452220423-4733-1-git-send-email-xlpang@redhat.com>
 <1452220423-4733-2-git-send-email-xlpang@redhat.com>
 <20160108084741.GB6295@dhcp-128-25.nay.redhat.com>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <568FB964.7030705@redhat.com>
Date: Fri, 8 Jan 2016 21:28:04 +0800
MIME-Version: 1.0
In-Reply-To: <20160108084741.GB6295@dhcp-128-25.nay.redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On 01/08/2016 at 04:47 PM, Minfei Huang wrote:
> On 01/08/16 at 10:33am, Xunlei Pang wrote:
>> +
>> +static int
>> +kexec_mark_range(unsigned long start, unsigned long end, bool protect)
>> +{
>> +	struct page *page;
>> +	unsigned int nr_pages;
>> +
>> +	/* For physical range: [start, end] */
>> +	if (!end || start > end)
>> +		return 0;
> This test !end is hard to be understood without the annotation. It is
> better to add the comment about it.

!end is just for uninitialized crashk resource with a zero end member,
maybe not so hard to understand :-)

Regards,
Xunlei

>
> Otherwise it looks good for me.
>
> Thanks
> Minfei
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
