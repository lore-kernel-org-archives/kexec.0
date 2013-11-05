Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0014.houston.hp.com ([15.201.24.17])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdWLY-0004zg-HM
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 02:26:25 +0000
Message-ID: <52785730.4030002@hp.com>
Date: Tue, 05 Nov 2013 10:25:52 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: building makedumpfile 1.5.4 for sles11sp2?
References: <52783DB9.7050000@gmail.com>
In-Reply-To: <52783DB9.7050000@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jay Lan <jay.zen.lan@gmail.com>
Cc: kexec@lists.infradead.org

On 11/05/2013 08:37 AM, Jay Lan wrote:
> Hi,
>
> It seems the makedumpfile.spec was written for fedora. It
> probably would work in rhel, but I was not able to build it
> in an sles11sp2 build environment...
>
> The spec file complained it needed elfutils-devel-static.
> I tried to install elfutils-devel-static-0.156-5.fc19.x86_64.rpm
> to an sles11sp2, it then complained more failed dependency.
>
> How do I build makedumpfile with community tarball in an
> sles11sp2 environment? Thanks in advance!
>

You can try to link it dynamically by this command:
make LINKTYPE=dynamic


> Jay
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
