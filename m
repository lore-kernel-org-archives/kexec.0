Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.17.20])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6MIo-0001wR-8v
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 22:02:00 +0000
Subject: Re: [PATCH v5 0/7] kexec: add generic support for elf kernel images
References: <20190823194919.30916-1-svens@stackframe.org>
 <22b40bb7-6f86-0a69-12b2-12d90124173d@gmx.de>
 <87blvxgkqw.fsf@morokweng.localdomain>
From: Helge Deller <deller@gmx.de>
Message-ID: <ac109a98-8a41-b3b2-9b2e-2bfe5bd3166a@gmx.de>
Date: Sat, 7 Sep 2019 00:01:45 +0200
MIME-Version: 1.0
In-Reply-To: <87blvxgkqw.fsf@morokweng.localdomain>
Content-Language: en-US
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: kexec@lists.infradead.org, Sven Schnelle <svens@stackframe.org>, linuxppc-dev@lists.ozlabs.org

On 06.09.19 23:47, Thiago Jung Bauermann wrote:
> Helge Deller <deller@gmx.de> writes:
>> This kexec patch series is the groundwork for kexec on the parisc architecture.
>> Since we want kexec on parisc, I've applied it to my for-next-kexec tree [1],
>> and can push it to Linus in the next merge window through the parisc tree [2].
>
> I just had a look at this version and it looks fine to me. Identical to
> the version I reviewed before except for the changes I suggested.
> Thanks, Sven!
>
>> If someone has any objections, or if you prefer to take it through
>> a kexec or powerpc tree, please let me know.
>>
>> Helge
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next-kexec
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/log/?h=for-next
>
> I noticed that the first patch is the only one that doesn't have my
> Reviewed-by. If you want, you can add it:
>
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Thanks for reviewing again!
I added your Reviewed-by to the patches in the for-next tree.

Helge

>
>> On 23.08.19 21:49, Sven Schnelle wrote:
>>> Changes to v4:
>>>  - rebase on current powerpc/merge tree
>>>  - fix syscall name in commit message
>>>  - remove a few unused #defines in arch/powerpc/kernel/kexec_elf_64.c
>>> ...
>>>  arch/Kconfig                                  |   3 +
>>>  arch/powerpc/Kconfig                          |   1 +
>>>  arch/powerpc/kernel/kexec_elf_64.c            | 545 +-----------------
>>>  include/linux/kexec.h                         |  23 +
>>>  kernel/Makefile                               |   1 +
>>>  .../kexec_elf_64.c => kernel/kexec_elf.c      | 394 +++----------
>>>  6 files changed, 115 insertions(+), 852 deletions(-)
>>>  copy arch/powerpc/kernel/kexec_elf_64.c => kernel/kexec_elf.c (50%)
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
