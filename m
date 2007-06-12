Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([192.83.249.54])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hy9fF-00033y-IU
	for kexec@lists.infradead.org; Tue, 12 Jun 2007 12:56:19 -0400
Message-ID: <466ECF37.6040303@zytor.com>
Date: Tue, 12 Jun 2007 09:52:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [KJ PATCH] Replacing memcpy(dest, src,
	PAGE_SIZE) with copy_page(dest, src)
	in arch/i386/kernel/machine_kexec.c
References: <1181616342.2282.8.camel@shani-win>
	<m1vedtpwks.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1vedtpwks.fsf@ebiederm.dsl.xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kernel-janitors@lists.osdl.org, kexec@lists.infradead.org, Shani Moideen <shani.moideen@wipro.com>, linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Shani Moideen <shani.moideen@wipro.com> writes:
> 
>> Hi,
>> Replacing memcpy(dest,src,PAGE_SIZE) with copy_page(dest,src) in
>> arch/i386/kernel/machine_kexec.c.
> 
> Please no.
> 
> People get creative in copy_page (especially mmx_copy_page),
> and this code path need something simple and stupid, that
> will work every time, especially when things are messed up
> elsewhere.
> 

memcpy() is pretty creative, too.  If you want something really dumb and
robust, you should probably create an inline:

/*
 * Eric sez: his code path need something simple and stupid, that
 * will work every time, especially when things are messed up
 * elsewhere.
 */
static inline void braindead_copy_page(void *dst, void *src)
{
	unsigned long ctr = PAGE_SIZE >> 2;

	asm volatile("cld; rep; movsl"
			: "+D" (dst), "+S" (src), "+c" (ctr)
			: : "memory");
}

(FWIW, the "cld" is supposed to be redundant, as DF=0 is supposed to be
guaranteed by the ABI.)

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
