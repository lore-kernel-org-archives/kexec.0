From: Coiby Xu <coxu@redhat.com>
Date: Wed, 13 Apr 2022 17:32:36 +0800
Subject: [PATCH v5 0/3] use more system keyrings to verify arm64 kdump
 kernel image signature
In-Reply-To: <20220411084306.GY163591@kunlun.suse.cz>
References: <20220401013118.348084-1-coxu@redhat.com>
 <Yk/hf7JEgALZOqE8@MiWiFi-R3L-srv>
 <20220408085931.GW163591@kunlun.suse.cz>
 <YlOAvM4qpSlHczOd@MiWiFi-R3L-srv>
 <20220411015218.ckw42xx5rrhidhpd@Rk>
 <20220411084306.GY163591@kunlun.suse.cz>
Message-ID: <20220413093236.faudcucbhn5jwatk@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Apr 11, 2022 at 10:43:06AM +0200, Michal Such?nek wrote:
>On Mon, Apr 11, 2022 at 09:52:18AM +0800, Coiby Xu wrote:
>> On Mon, Apr 11, 2022 at 09:13:32AM +0800, Baoquan He wrote:
>> > On 04/08/22 at 10:59am, Michal Such?nek wrote:
>> > > On Fri, Apr 08, 2022 at 03:17:19PM +0800, Baoquan He wrote:
>> > > > Hi Coiby,
>> > > >
>> > > > On 04/01/22 at 09:31am, Coiby Xu wrote:
>> > > > > Currently, a problem faced by arm64 is if a kernel image is signed by a
>> > > > > MOK key, loading it via the kexec_file_load() system call would be
>> > > > > rejected with the error "Lockdown: kexec: kexec of unsigned images is
>> > > > > restricted; see man kernel_lockdown.7".
>> > > > >
>> > > > > This patch set allows arm64 to use more system keyrings to verify kdump
>> > > > > kernel image signature by making the existing code in x64 public.
>> > > >
>> > > > Thanks for updating. It would be great to tell why the problem is
>> > > > met, then allow arm64 to use more system keyrings can solve it.
>> > >
>> > > The reason is that MOK keys are (if anywhere) linked to the secondary
>>                                                                ^^^^^^^^^
>>                                                                platform?
>> > > keyring, and only primary keyring is used on arm64.
>>
>> Thanks Michal for providing the info! Btw, I think you made a typo
>> because MOK keys are linked to the platform keyring, right?
>
>No, I mean secondary, through this patchset:
>https://lore.kernel.org/lkml/YhKP12KEmyqyS8rj at iki.fi/

Thanks for the info! This provides another approach to verify kernel
image's signature via the secondary keyring once the end-use chooses to
trust MOK keys by setting MokListTrustedRT.

>
>Apparently support for importing the MOK keys into the platform keyring
>also exists but I am not sure if this is upstream or downstream feature.

This is actually an upstream feature,

commit 15ea0e1e3e185040bed6119f815096f2e4326242
Author: Josh Boyer <jwboyer@fedoraproject.org>
Date:   Thu Dec 13 01:37:56 2018 +0530

     efi: Import certificates from UEFI Secure Boot
     
     Secure Boot stores a list of allowed certificates in the 'db' variable.
     This patch imports those certificates into the platform keyring. The shim
     UEFI bootloader has a similar certificate list stored in the 'MokListRT'
     variable. We import those as well.
     
     Secure Boot also maintains a list of disallowed certificates in the 'dbx'
     variable. We load those certificates into the system blacklist keyring
     and forbid any kernel signed with those from loading.
     
     [zohar at linux.ibm.com: dropped Josh's original patch description]
     Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
     Signed-off-by: David Howells <dhowells@redhat.com>
     Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
     Acked-by: Serge Hallyn <serge@hallyn.com>
     Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

>
>At any rate the MOK keys are not included in the primary keyring which
>is the only keyring currently in use for kexec on arm64.

Good summary, thanks!

>
>Thanks
>
>Michal
>

-- 
Best regards,
Coiby


