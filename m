Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjoD6-00085J-R8
 for kexec@lists.infradead.org; Tue, 04 Jun 2013 10:11:26 +0000
Message-ID: <51ADBD41.9080702@redhat.com>
Date: Tue, 04 Jun 2013 18:11:13 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Add a help message into man page of makedumpfile for
 -b option.
References: <20130530084418.15640.42675.stgit@k.asiapacific.hpqcorp.net>
 <51A80A66.7080003@redhat.com> <51A8175A.6010302@redhat.com>
 <20130604163821.c9e51967c41afabfa101cc94@mxc.nes.nec.co.jp>
In-Reply-To: <20130604163821.c9e51967c41afabfa101cc94@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: oomichi@mxs.nes.nec.co.jp, bhe@redhat.com, jin.wang@hp.com, kexec@lists.infradead.org, gang.xing@hp.com, nan.chen2@hp.com, lisa.mitchell@hp.com, vgoyal@redhat.com, nigel.croxon@hp.com, jingbai.ma@hp.com

On 06/04/2013 03:38 PM, Atsushi Kumagai wrote:
> On Fri, 31 May 2013 11:22:02 +0800
> Dave Young <dyoung@redhat.com> wrote:
> 
>> On 05/31/2013 10:26 AM, Dave Young wrote:
>>> Add Ken'ichi Ohmichi to cc list and remove redhat list from cc
>>>
>>> On 05/30/2013 04:44 PM, Jingbai Ma wrote:
>>>> This is a minor change that only adds a help message to -b option in makedumpfile man page.
>>>> This message has been in Red Hat's makedumpfile source, they would like it in upstream also.
>>>>
>>>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>>>> ---
>>>>  makedumpfile.8 |    4 ++++
>>>>  1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/makedumpfile.8 b/makedumpfile.8
>>>> index cfd1270..1e844db 100644
>>>> --- a/makedumpfile.8
>>>> +++ b/makedumpfile.8
>>>> @@ -534,6 +534,10 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
>>>>  Print debugging message.
>>>>  
>>>>  .TP
>>>> +\fB-b <order>\fR
>>>> +cache 2^order pages in ram when generating vmcore info before writing to output
>>
>> Hi, Jingbai
>>
>> A nitpick:
>> The first character should be capital 'C'
> 
> It's basically good to me. But the position of insertion isn't
> suitable and the message isn't correct.
> Moreover, the same can be said about current print_usage().
> 
> So I'll merge this patch with change as below:
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index cfd1270..61bd5f2 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -364,6 +364,11 @@ on the following example.
>  # makedumpfile \-\-reassemble dumpfile1 dumpfile2 dumpfile
> 
>  .TP
> +\fB\-b\fR \fI<order>\fR
> +Cache 2^order pages in ram when generating \fIDUMPFILE\fR before writing to output.
> +The default value is 4.
> +
> +.TP
>  \fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
>  Specify the buffer size in kilo bytes for analysis in the cyclic mode.
>  Actually, the double of \fIbuffer_size\fR kilo bytes will be allocated in memory.
> 
> 
> And I'll fix print_usage() too.

Great, Thanks a lot!

> 
> 
> Thanks
> Atsushi Kumagai
> 


-- 
Thanks
Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
