Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mup1Z-00BHuU-Nn
 for kexec@lists.infradead.org; Wed, 08 Dec 2021 04:57:52 +0000
Message-ID: <c8e76c03-6fae-4a9a-aa25-826327e9d5a5@oracle.com>
Date: Tue, 7 Dec 2021 22:56:47 -0600
Subject: Re: [PATCH RESEND v2 0/5] Avoid requesting page from DMA zone when no
 managed pages
Content-Language: en-US
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207031631.GA5604@MiWiFi-R3L-srv>
 <01b4831f-7136-80af-a6cb-93698cb31fc4@oracle.com>
 <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
From: John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <20211207203328.2cda72e37b8c944e4276554a@linux-foundation.org>
MIME-Version: 1.0
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, linux-mm@kvack.org, hch@lst.de, robin.murphy@arm.com, cl@linux.com, penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz, m.szyprowski@samsung.com, kexec@lists.infradead.org, rppt@linux.ibm.com

On 12/7/21 22:33, Andrew Morton wrote:
> On Mon, 6 Dec 2021 22:03:59 -0600 John Donnelly <John.p.donnelly@oracle.com> wrote:
> 
>> On 12/6/21 9:16 PM, Baoquan He wrote:
>>> Sorry, forgot adding x86 and x86/mm maintainers
>>
>> Hi,
>>
>>     These commits need applied to Linux-5.15.0 (LTS) too since it has the
>> original regression :
>>
>>    1d659236fb43 ("dma-pool: scale the default DMA coherent pool
>> size with memory capacity")
>>
>> Maybe add "Fixes" to the other commits ?
> 
> And cc:stable, please.  "Fixes:" doesn't always mean "should be
> backported
>

Hi.


Does this mean we need a v3 version ?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
