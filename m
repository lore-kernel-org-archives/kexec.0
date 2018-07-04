Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fabad-0004an-AO
 for kexec@lists.infradead.org; Wed, 04 Jul 2018 06:48:37 +0000
Received: by mail-lj1-f193.google.com with SMTP id q5-v6so3414335ljh.12
 for <kexec@lists.infradead.org>; Tue, 03 Jul 2018 23:48:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2feb77ba-9b52-7aad-a216-a36824ea8b47@redhat.com>
References: <1530308908-15528-1-git-send-email-bhsharma@redhat.com>
 <CACi5LpP14A5Lf2wgszMxF520y+epphTQatrOaS7CZ9CT13Nvtg@mail.gmail.com>
 <2feb77ba-9b52-7aad-a216-a36824ea8b47@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 4 Jul 2018 12:18:21 +0530
Message-ID: <CACi5LpM_fRYoyt3sKp4jpf_95rqKKu=JEsOUwgPgk=X9a=RqpA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix calculation of page_offset in case we are
 running cases other than mem-usage
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec mailing list <kexec@lists.infradead.org>

On Wed, Jul 4, 2018 at 12:15 AM, Kazuhito Hagio <k-hagio@ab.jp.nec.com> wrote:
> On 7/3/2018 1:23 AM, Bhupesh Sharma wrote:
>> Hello Kazu-san,
>>
>> On Sat, Jun 30, 2018 at 3:18 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>>> Patch f49ca13e5eed5bbdc69e0fd5ef099cb46050cb3d added '--mem-usage'
>>> support for arm64 architecture.
>>>
>>> However, we also need to make sure that the calculation of
>>> 'page_offset' is valid in case we are running cases other than
>>> '--mem-usage'.
>>>
>>> This patch does the same. I tested this patch on my qualcomm and apm
>>> mustang arm64 boards.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>>  arch/arm64.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/arm64.c b/arch/arm64.c
>>> index c9dab677f2c9..2fd3e1874376 100644
>>> --- a/arch/arm64.c
>>> +++ b/arch/arm64.c
>>> @@ -222,6 +222,12 @@ get_stext_symbol(void)
>>>  int
>>>  get_machdep_info_arm64(void)
>>>  {
>>> +       /* Check if va_bits is still not initialized. If still 0, call
>>> +        * get_versiondep_info() to initialize the same.
>>> +        */
>>> +       if (!va_bits)
>>> +               get_versiondep_info_arm64();
>>> +
>>>         if (!calculate_plat_config()) {
>>>                 ERRMSG("Can't determine platform config values\n");
>>>                 return FALSE;
>>> --
>>> 2.7.4
>>>
>>
>> This is an important fix for arm64 makedumpfile as it fixes issues
>> reported with Fedora when we use makedumpfile for cases other than
>> '--mem-usage'.
>>
>> So kindly consider this one for the next makedumpfile release.
>
> Hi Bhupesh,
>
> I understood its importance and I think that this problem should be
> fixed before the v1.6.4 release.  Thanks for letting me know it.
>
> I've reviewed the patch and the process flow of arm64 architecture
> around it.  It looks good to me, and applied.

Great. Thanks a lot for your help.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
