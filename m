From: Coiby Xu <coxu@redhat.com>
Date: Thu, 12 May 2022 14:54:09 +0800
Subject: [PATCH v7 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
In-Reply-To: <Ynynwe7Q0+0DSABQ@MiWiFi-R3L-srv>
References: <20220512023402.9913-1-coxu@redhat.com>
 <20220512023402.9913-3-coxu@redhat.com>
 <Ynx1DUvDTL1R4Pj5@MiWiFi-R3L-srv> <YnyEafqEcSh/wRRN@MiWiFi-R3L-srv>
 <20220512043310.v3e22423ybe4z65e@Rk>
 <Ynynwe7Q0+0DSABQ@MiWiFi-R3L-srv>
Message-ID: <20220512065409.xxegsttgwfh63fsv@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, May 12, 2022 at 02:22:57PM +0800, Baoquan He wrote:
>On 05/12/22 at 12:33pm, Coiby Xu wrote:
[...]
>> > Just to make clear , is this patch fixing an issue, or it's just an
>> > preparation for later patch's use?
>> >
>> > Or I should ask in another way, any problem is solved with this patch?
>>
>> At least it doesn't fix an issue that satisfy the criteria listed in
>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>
>Then it should not be CC-ed to stable.

OK, I'll drop "CC:" in next version.

>
>>
>> >
>> >
>> > > > Reviewed-by: Michal Suchanek <msuchanek@suse.de>
>> > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> > > > ---
>> > >
>> > > You can put the note here, it won't be added to commit log when merged.
>> > > Maybe it can be removed when merged.
>>
>> Thanks for the suggestion! Shall I send a version to fix this problem or
>> can I just bother the maintainer to remove it?
>
>Better send a clean one, it will save maintainer's time, they can pick
>it directly.

Thanks for the confirmation! I'll simply delete them because,
1. these notes don't make sense anymore if I don't CC the patches to the stable
    tree 
2. I've explained in the cover letter the first two patches
    are the prerequisite patches for the 3rd patch.

-- 
Best regards,
Coiby


