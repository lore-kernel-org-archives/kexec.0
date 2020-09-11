Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410077.outbound.protection.outlook.com
 ([40.107.141.77] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGeoX-0006wo-54
 for kexec@lists.infradead.org; Fri, 11 Sep 2020 08:53:50 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: makedumpfile: a feature question about filtering
Date: Fri, 11 Sep 2020 08:53:31 +0000
Message-ID: <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
In-Reply-To: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: piliu <piliu@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan,

-----Original Message-----
> Hello,
> 
> There is an appeal which only wants to save some user page including env
> and args pages, and discards the other user space pages.

I understand that it's helpful to get them even with -d 31 for crash's
"ps -a" option..

> 
> To achieve this feature, mm_struct's members "arg_start, arg_end,
> env_start, env_end;" should be accessed. So we need to export mm_struct
> and init_mm through vmcore.

How many offsets/sizes will be required to walk all tasks?
If kernel maintainers accept it, I will not oppose that feature..

(or it would be simpler to mark the pages something special when allocating,
but I don't feel like it's easy to change kernel to do so.)

Thanks,
Kazu

> 
> This somewhat overlaps with the function of crash utility. And I want to
> know if this feature is acceptable in upstream.
> 
> Any comment and suggestion?
> 
> Thanks,
> Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
