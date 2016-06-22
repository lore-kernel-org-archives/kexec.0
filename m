Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFs2D-00025N-0z
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 23:58:17 +0000
Received: by mail-pf0-x244.google.com with SMTP id 66so5196507pfy.1
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 16:57:56 -0700 (PDT)
Subject: Re: [PATCH v3 0/9] kexec_file_load implementation for PowerPC
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160622232946.793d6c04@350D> <2895031.4C8tZ3BP2G@hactar>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <576B25FF.1010307@gmail.com>
Date: Thu, 23 Jun 2016 09:57:51 +1000
MIME-Version: 1.0
In-Reply-To: <2895031.4C8tZ3BP2G@hactar>
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
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org



On 23/06/16 03:02, Thiago Jung Bauermann wrote:
> Hello Balbir,
>
Hi Thiago
 
>>> 3. have IMA pass-on its event log (where integrity measurements are
>>>
>>>    registered) accross kexec to the second kernel, so that the event
>>>    history is preserved.
>>
>> OK.. and this is safe? Do both the kernels need to be signed by the
>> same certificate?
> 
> They don't. The integrity of the event log (assuming that is what you mean 
> by "this" in "this is safe") is guaranteed by the TPM device. Each event in 
> the measurement list extends a PCR and records its PCR value. It is 
> cryptographically guaranteed that if you replay the PCR extends recorded in 
> the event log and in the end of the process they match the current PCR 
> values in the TPM device, then that event log is correct.


What I meant was how does the new kernel know that the old kernel did not
cheat while passing on the values? I presume because we trust that kernel
via a signature.


and

How do we know the new kernel is safe to load - I guess via a signature that
the new kernel is signed with (assuming it is present in the key ring).

Balbir Singh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
