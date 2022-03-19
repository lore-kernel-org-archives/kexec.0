From: Coiby Xu <coxu@redhat.com>
Date: Sat, 19 Mar 2022 09:41:23 +0800
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
In-Reply-To: <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
 <20220318122110.7qjrnrduwytjle3w@Rk>
 <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
Message-ID: <20220319014123.v26w2snihbuyd4fz@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Mar 18, 2022 at 02:53:37PM +0100, Milan Broz wrote:
>On 18/03/2022 13:21, Coiby Xu wrote:
>...
>>>Why is it not done through keyring and forcing kdump to retain key there
>>>(under the same keyring key name as dm-crypt used)?
>>>Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
>>>That's all you need, or not? Why do you need to add another "kdump:" thing?
>>>IOW why kdump cannot copy the key to keyring under the name dm-crypt
>>>has in the mapping table and let dm-crypt activate the device almost without
>>>code changes?
>>
>>Sorry, I haven't explained how kdump works. Once the 1st kernel crashes and
>>the system boots into the kdump kernel, the kdump kernel only have direct
>>access to the memory exclusively reserved for it i.e. the kdump kernel
>>loses the direct access to the keyring constructed in the 1st kernel. In
>>theory, the kdump kernel could do some "hacking" to find out the key
>>stored in the memory directly managed by the 1st kernel but I imagine
>>this would be difficult task (imagine I present the memory dump of my
>>computer to you and ask you to rebuild all the relevant kernel data
>>structures and find the key). Besides, it's not reliable to read the
>>memory directly managed by the first kernel for example the memory could
>>be corrupt. So we have to pass the master key from the 1st kernel to the kdump
>>kernel.
>
>OK, then why you cannot store it to the (2nd) kdump kernel keyring?
>(From the kdump area copy, then you do not need to patch anything else
>in dm-crypt than that one line storing the key to the kdump area.)

cryptsetup stores the master key in the thread keyring
(KEY_SPEC_THREAD_KEYRING). I couldn't come up with a easy way to store
the key to the (2nd) kdump kernel keyring. For example, one problem is
how can I know in adance the thread ID of cryptsetup? I imagine
drivers/md/dm-crypt.c needs to support a new type of message in
crypt_message so cryptsetup can tell dm-crypt to store the master key
in the thread keyring as a preparation for opening the device. So one
line change of code isn't sufficient. What's more important is I don't see 
any benefit by doing so I regards storing the key to the kdump kernel
keyring first as an unnecessary step.

>
>A clear approach would be to store the key in the 2nd kernel kdump keyring
>and allow userspace to read it.
>Then cryptsetup can just validate the key (LUKS key digest does not use Argon)
>and activates it without asking for a passphrase.

Thanks for bringing my attention to validating the key! Currently I
simply skip key validation in cryptsetup when implementing the
"--kdump-master-key" option because it requires pass the master key to
the user space. I have a side question, if somehow the master key is
changed and the wrong key is used to get the expanded key, will it lead
to a devastating effect say corrupting the user data on the disk?

>Perhaps this will need some new cryptsetup option (or API call), but I think
>it can be done.
>
>Or, you can actually simulate it with
>  cryptsetup open ... --master-key-file <file>
>where this keyfile contains directly the volume key, not a passphrase.
>The key digest is verified in this case only; no costly PBKDF is needed.
>
>If you have a way to retrieve the kdump stored key to kdump userspace, this
>is perhaps a much simpler solution.
>
>All this is against all countermeasures to not expose encryption key
>directly - but if kdump is debugging environment, just saying...

I respect and appreciate all the efforts done by you and other community
members to increase security margin so the last thing I want to do is to
reverse the security measures. Besides, I believe some users choose to
dump vmcore to an encrypted disk exactly out of security concern. The
only thing this patch set does about master key is to store it in the
memory exclusively reserved for kdump. To be precise, storing the master
key in the memory exclusively reserved for kdump may be different from
what you mean by "exposing encryption key directly". This reserved memory
won't be used by the 1st kernel (which means if we reserve 1GB more for
the kdump kernel, the 1st kernel would have 1GB less kernel to use. And I
would expect strong objection from the user due to a loss of 1GB memory).
Only kexec knows how to store the master key in this exclusively reserved
memory area and but kexec itself doesn't know to retrieve the master key in
the 1st kernel. So the situation is similar to how expanded key is stored.
struct crypto_aes_ctx has the expanded key, but there is no API to retrieve
it. If you still think this line of reasoning doesn't convince you, how
about encrypting the master key before storing the key to the kdump memory?
kexec could calculate the SHA256 digest of loaded kdump kernel and initrd.
We can use this SHA256 digest to get an encryption key and then encrypt
the master key.

>
>Milan
>

-- 
Best regards,
Coiby


