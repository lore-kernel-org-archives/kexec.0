From: Milan Broz <gmazyland@gmail.com>
Date: Fri, 18 Mar 2022 14:53:37 +0100
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
In-Reply-To: <20220318122110.7qjrnrduwytjle3w@Rk>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c857dcf8-024e-ab8a-fd26-295ce2e0ae41@gmail.com>
 <20220318122110.7qjrnrduwytjle3w@Rk>
Message-ID: <a5b9e66c-235b-51dd-234c-b543dbacc464@gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 18/03/2022 13:21, Coiby Xu wrote:
...
>> Why is it not done through keyring and forcing kdump to retain key there
>> (under the same keyring key name as dm-crypt used)?
>> Kernel dm-crypt supports this already; LUKS2 uses keyring by default too.
>> That's all you need, or not? Why do you need to add another "kdump:" thing?
>> IOW why kdump cannot copy the key to keyring under the name dm-crypt
>> has in the mapping table and let dm-crypt activate the device almost without
>> code changes?
> 
> Sorry, I haven't explained how kdump works. Once the 1st kernel crashes and
> the system boots into the kdump kernel, the kdump kernel only have direct
> access to the memory exclusively reserved for it i.e. the kdump kernel
> loses the direct access to the keyring constructed in the 1st kernel. In
> theory, the kdump kernel could do some "hacking" to find out the key
> stored in the memory directly managed by the 1st kernel but I imagine
> this would be difficult task (imagine I present the memory dump of my
> computer to you and ask you to rebuild all the relevant kernel data
> structures and find the key). Besides, it's not reliable to read the
> memory directly managed by the first kernel for example the memory could
> be corrupt. So we have to pass the master key from the 1st kernel to the kdump
> kernel.

OK, then why you cannot store it to the (2nd) kdump kernel keyring?
(From the kdump area copy, then you do not need to patch anything else
in dm-crypt than that one line storing the key to the kdump area.)

A clear approach would be to store the key in the 2nd kernel kdump keyring
and allow userspace to read it.
Then cryptsetup can just validate the key (LUKS key digest does not use Argon)
and activates it without asking for a passphrase.
Perhaps this will need some new cryptsetup option (or API call), but I think
it can be done.

Or, you can actually simulate it with
   cryptsetup open ... --master-key-file <file>
where this keyfile contains directly the volume key, not a passphrase.
The key digest is verified in this case only; no costly PBKDF is needed.

If you have a way to retrieve the kdump stored key to kdump userspace, this
is perhaps a much simpler solution.

All this is against all countermeasures to not expose encryption key
directly - but if kdump is debugging environment, just saying...

Milan

