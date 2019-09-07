Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6Pd5-0002Hd-NH
 for kexec@lists.infradead.org; Sat, 07 Sep 2019 01:35:09 +0000
References: <20190823194919.30916-1-svens@stackframe.org>
 <22b40bb7-6f86-0a69-12b2-12d90124173d@gmx.de>
 <87blvxgkqw.fsf@morokweng.localdomain>
 <ac109a98-8a41-b3b2-9b2e-2bfe5bd3166a@gmx.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v5 0/7] kexec: add generic support for elf kernel images
In-reply-to: <ac109a98-8a41-b3b2-9b2e-2bfe5bd3166a@gmx.de>
Date: Fri, 06 Sep 2019 22:34:57 -0300
Message-ID: <87a7bghose.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Helge Deller <deller@gmx.de>
Cc: kexec@lists.infradead.org, Sven Schnelle <svens@stackframe.org>, linuxppc-dev@lists.ozlabs.org


Helge Deller <deller@gmx.de> writes:

> On 06.09.19 23:47, Thiago Jung Bauermann wrote:
>> Helge Deller <deller@gmx.de> writes:
>>> This kexec patch series is the groundwork for kexec on the parisc architecture.
>>> Since we want kexec on parisc, I've applied it to my for-next-kexec tree [1],
>>> and can push it to Linus in the next merge window through the parisc tree [2].
>>
>> I just had a look at this version and it looks fine to me. Identical to
>> the version I reviewed before except for the changes I suggested.
>> Thanks, Sven!
>>
>>> If someone has any objections, or if you prefer to take it through
>>> a kexec or powerpc tree, please let me know.
>>>
>>> Helge
>>>
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next-kexec
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next
>>
>> I noticed that the first patch is the only one that doesn't have my
>> Reviewed-by. If you want, you can add it:
>>
>> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Thanks for reviewing again!
> I added your Reviewed-by to the patches in the for-next tree.

Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
