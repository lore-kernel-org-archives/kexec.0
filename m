Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZqEI-00030p-H4
 for kexec@lists.infradead.org; Wed, 17 Aug 2016 02:05:19 +0000
Received: by mail-pf0-x243.google.com with SMTP id h186so6456224pfg.2
 for <kexec@lists.infradead.org>; Tue, 16 Aug 2016 19:04:57 -0700 (PDT)
Subject: Re: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take
 kexec_buf as argument.
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1906561.y8blzB2uZ8@hactar> <fab1a3ec-5252-3ca7-6382-15b84a19ccdb@gmail.com>
 <2089791.XEmIvA1k4K@hactar>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <edca3e4a-1901-eab4-6626-390c835b00c7@gmail.com>
Date: Wed, 17 Aug 2016 12:04:49 +1000
MIME-Version: 1.0
In-Reply-To: <2089791.XEmIvA1k4K@hactar>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>



On 17/08/16 04:49, Thiago Jung Bauermann wrote:
> Am Dienstag, 16 August 2016, 16:15:55 schrieb Balbir Singh:
>> On 16/08/16 00:49, Thiago Jung Bauermann wrote:
>>> Am Montag, 15 August 2016, 17:30:49 schrieb Balbir Singh:
>>>> On Thu, Aug 11, 2016 at 08:08:07PM -0300, Thiago Jung Bauermann wrote:
>>>>> Adapt all callers to the new function prototype.
>>>>
>>>> Could you please expand on this?
>>>
>>> Is the following better?
>>>
>>> Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
>>
>> Yes and the reason for doing so? Consolidation/clarity of implementation?
> 
> Indeed. What about this commit message?
> 
> Subject: [PATCH v5 02/13] kexec_file: Change kexec_add_buffer to take  
>  kexec_buf as argument.
> 
> This is done to simplify the kexec_add_buffer argument list.
> Adapt all callers to set up a kexec_buf to pass to kexec_add_buffer.
> 
> In addition, change the type of kexec_buf.buffer from char * to void *.
> There is no particular reason for it to be a char *, and the change
> allows us to get rid of 3 existing casts to char * in the code.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> 


Looks good

Balbir

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
