Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bhdwX-00066l-Lr
 for kexec@lists.infradead.org; Wed, 07 Sep 2016 14:35:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org>
Date: Wed, 07 Sep 2016 09:19:40 -0500
In-Reply-To: <8760q7lswz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
 message of "Wed, 07 Sep 2016 08:51:24 -0500")
Message-ID: <871t0vlrlv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Balbir Singh <bsingharora@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> Hello,
>>
>> The purpose of this new version of the series is to fix a small issue that
>> I found, which is that the kernel doesn't remove the memory reservation
>> for the hand-over buffer it received from the previous kernel in the
>> device tree it sets up for the next kernel. The result is that for each
>> successive kexec, a stale hand-over buffer is left behind, wasting memory.
>>
>> This is fixed by changes to kexec_free_handover_buffer and
>> setup_handover_buffer in patch 2. The other change is to fix checkpatch
>> warnings in the last patch.
>
> This is fundamentally broken.  You do not increase the integrity of a
> system by dropping integrity checks.
>
> No. No. No. No.
>
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

To be constructive the way we have handled similiar situations in the
past (hotplu memory) is to call kexec_load again.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
