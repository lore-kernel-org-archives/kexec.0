Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCo6K-000598-Nq
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 08:19:29 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EDA3D3EE0B5
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 17:19:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CFC6C45DD74
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 17:19:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id ADFEE45DE4D
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 17:19:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A1AF61DB8040
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 17:19:26 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 515E91DB803A
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 17:19:26 +0900 (JST)
Date: Wed, 28 Mar 2012 17:19:14 +0900 (   )
Message-Id: <20120328.171914.59657074.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <4F72C4C8.2000600@canonical.com>
References: <20120328141809.fac2af86.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120328.165020.183027661.d.hatayama@jp.fujitsu.com>
 <4F72C4C8.2000600@canonical.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: louis.bouchard@canonical.com
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, crash-utility@redhat.com

Hello,

From: Bouchard Louis <louis.bouchard@canonical.com>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Date: Wed, 28 Mar 2012 09:59:04 +0200

> Hello,
> =

> Le 28/03/2012 09:50, HATAYAMA Daisuke a =E9crit :
>> =

>> Yes, I of course agree with the fact that makedumpfile for kdump 2nd
>> kernel should always be built in statically linked way.
>> =

>> But I think two problems are different, that is, the problem making
>> users easily able to choose build option by autotools, and the problem
>> guranteeing that the makedumpfile for kdump 2nd kernel be built always
>> statically.
>> =

> =

> I don't see why it should be statically linked. Debian & Ubuntu both use
> a dynamically linked makedumpfile for the 2nd kdump kernel.
> =

> Debian executes makedumpfile on the 'real' root FS while Ubuntu runs it
> in the initramfs. It is simply a chroot on the root FS being mounted on
> /root.
> =


Thanks. I've noticed the fact on Debian for the first time.

Root filesystem can be broken due to filesystem related bugs or disk
crash. So, on fedora/RHEL environments, root filesystem is not mounted
in kdump initrd/initramfs. Necessary resources in 2nd kernel,
including makedumpfile, are all packed in kdump initrd/initramfs.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
