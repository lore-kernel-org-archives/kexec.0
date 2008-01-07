Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JBwIS-0008Sc-FS
	for kexec@lists.infradead.org; Mon, 07 Jan 2008 18:02:08 +0000
Message-ID: <4782684F.3090802@zytor.com>
Date: Mon, 07 Jan 2008 09:58:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: kexec refuses to boot latest -mm
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<478264CA.5090300@zytor.com>
	<20080107175303.GA9319@linux.vnet.ibm.com>
In-Reply-To: <20080107175303.GA9319@linux.vnet.ibm.com>
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
To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

Dhaval Giani wrote:
>>
>> Could you give more details of your setup?  I'm trying to figure out 
>> exactly what it is in kexec that goes goofy, but there seems to be an 
>> enormous number of codepaths, all different, depending on things like which 
>> kind of kernel.  The more closely I can replicate your failure, the quicker 
>> I should be able to locate the problem.
>>
> 
> 
> (Anything else you need, please let me know!)

- Is your pre- and post-kexec kernels the same kernel?
- What format are you using for the post-kexec kernel?
- Exact kexec command line?
- Exact boot configuration for the pre-kexec kernel?

If you can send me the images that would be extra helpful.

Thanks!

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
