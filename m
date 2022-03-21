From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Mon, 21 Mar 2022 09:28:15 -0300
Subject: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
In-Reply-To: <20220321014150.w6wux5azabweu7dr@Rk>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
 <20220321014150.w6wux5azabweu7dr@Rk>
Message-ID: <1ccc06f4-3fff-8a6e-2a66-3f117ca6f282@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 20/03/2022 22:41, Coiby Xu wrote:
> [...]
> 
> I believe some users have security concern for where to save vmcore.
> This use case exactly fits your description and your proposed solution
> shall be good for this type of users. But I think many more users may
> just choose to encrypt the hard drive when installing the system and
> they would naturally expect kdump to work for the case of full disk
> encryption. So your proposed solution may not address the latter case 
> where there is a much large user base.
> 

Thanks Coiby, makes sense, your idea is more generic and seems to
address all the use cases!
Cheers,


Guilherme

