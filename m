From: Agrain Patrick <patrick.agrain@al-enterprise.com>
Date: Wed, 6 Apr 2022 16:02:23 +0000
Subject: EXT: RE: crash: read error on type: "memory section root table"
In-Reply-To: <TYYPR01MB6777B62FFF63DBFC18E6EBBADDE79@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <DB7PR08MB327305868D5DF87C2E31B972CA1E9@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB67776D129929014239C34414DD1F9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <DB7PR08MB32733EC5606D43D47FDEDCC1CAE09@DB7PR08MB3273.eurprd08.prod.outlook.com>
 <TYYPR01MB6777C0B689B45FE92EB4712FDDE79@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <TYYPR01MB6777B62FFF63DBFC18E6EBBADDE79@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Message-ID: <DB7PR08MB327397189AB7853206D01EBFCAE79@DB7PR08MB3273.eurprd08.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org



-----Message d'origine-----
De?: HAGIO KAZUHITO(?????) <k-hagio-ab@nec.com> 
Envoy??: mercredi 6 avril 2022 10:06
??: Agrain Patrick <patrick.agrain@al-enterprise.com>
Cc?: kexec at lists.infradead.org; Discussion list for crash utility usage, maintenance and development <crash-utility@redhat.com>
Objet?: RE: EXT: RE: crash: read error on type: "memory section root table"

-----Original Message-----
> -----Original Message-----
> > Hello,
> >
> > Suggested trace above gives following information after a crash -d 8 command:
> > <...>
> > kernel NR_CPUS: 2
> > <readmem: ffffffffa4925820, KVADDR, "high_memory", 8, (FOE), 
> > 56017b542648>
> > <read_diskdump: addr: ffffffffa4925820 paddr: 12925820 cnt: 8>
> > read_diskdump: paddr/pfn: 12925820/12925 -> cache physical page: 
> > 12925000
> > GETBUF(328 -> 0)
> > FREEBUF(0)
> > GETBUF(328 -> 0)
> > FREEBUF(0)
> > PAGESIZE=4096
> > mem_section_size = 16384
> > NR_SECTION_ROOTS = 2048
> > NR_MEM_SECTIONS = 524288
> > SECTIONS_PER_ROOT = 256
> > SECTION_ROOT_MASK = 0xff
> > PAGES_PER_SECTION = 32768
> > <readmem: ffffffffa4926db0, KVADDR, "mem_section", 8, (FOE), 
> > 7ffd1b6bb000>
> > <read_diskdump: addr: ffffffffa4926db0 paddr: 12926db0 cnt: 8>
> > read_diskdump: paddr/pfn: 12926db0/12926 -> cache physical page: 
> > 12926000
> > <readmem: ffff904c7f7fc000, KVADDR, "memory section root table", 
> > 16384, (FOE), 56017da26fd0>
> > <read_diskdump: addr: ffff904c7f7fc000 paddr: 3f7fc000 cnt: 4096>
> > read_diskdump: paddr/pfn: 3f7fc000/3f7fc -> cache physical page: 
> > 3f7fc000
> > crash: PAG3 - errno=2 r=0 pd.size=49
> > read_diskdump: READ_ERROR: cannot cache page: 3f7fc000
> > crash: read error: kernel virtual address: ffff904c7f7fc000  type: "memory section root table"
> 
> hmm, r=0 means end of file, can you check again whether pd.offset 
> exceeds the dumpfile size?  If so, somehow the dumpfile is shorter than expected.
> 
> I think a RHEL-based kexec-tools does "sync" after makedumpfile, but 
> can you check?

> > Note 2: The debug message of makedumpfile report 'Write bytes     : 17364943', but the file is ~5MB for '-d 31' opton.

This also looks the same situation.

Does cp command always work on your machine to capture /proc/vmcore?
e.g. with a RHEL-based kexec-tools:

  core_collector cp

The size of a vmcore should become almost same as memory size.

Yes, if I'm using the /proc/vmcore instead, crash has no problem to read it... except that in a very few number of cases, the /proc/vmcore has less bytes than expected (1031389184 bytes on a 1GB RAM system) and then crash also fails.

Thanks,
Kazu

